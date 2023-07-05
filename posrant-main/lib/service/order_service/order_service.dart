import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {
  Future<bool> create({
    required String tableNumber,
    required List items,
    required double total,
    required String paymentMethod,
    required String status,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("orders").add({
        "owner_id": FirebaseAuth.instance.currentUser!.uid,
        "created_at": Timestamp.now(),
        "table_number": tableNumber,
        "payment_method": paymentMethod,
        "items": items,
        "total": total,
        "status": status,
      });

      var snapshot = await FirebaseFirestore.instance
          .collection("tables")
          .where("table_number", isEqualTo: tableNumber)
          .where(
            "owner_id",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();

      var tableDocId = snapshot.docs.first.id;

      await FirebaseFirestore.instance
          .collection("tables")
          .doc(tableDocId)
          .update(
        {
          "status": "Used",
        },
      );

      return true; // Operasi berhasil
    } catch (error) {
      // ignore: avoid_print
      print(error);
      return false; // Terjadi kesalahan atau gagal
    }
  }

  setOrderPaid({
    required String orderId,
    required String tableNumber,
  }) async {
    await FirebaseFirestore.instance.collection("orders").doc(orderId).update({
      "status": "Paid",
    });

    var snapshot = await FirebaseFirestore.instance
        .collection("tables")
        .where("table_number", isEqualTo: tableNumber)
        .where(
          "owner_id",
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .get();

    var tableDocId = snapshot.docs.first.id;

    await FirebaseFirestore.instance
        .collection("tables")
        .doc(tableDocId)
        .update(
      {
        "status": "Available",
      },
    );
  }

  Stream<int> getOrderCountStreamByStatus(String status) {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: status)
        .where(
          "owner_id",
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
}
