import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
// ignore: unnecessary_import
import '../controller/pos_order_controller.dart';

class PosOrderView extends StatefulWidget {
  final String tableNumber;

  const PosOrderView({Key? key, required this.tableNumber}) : super(key: key);

  Widget build(context, PosOrderController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pos Order - #$tableNumber"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[500],
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: null,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: "Search products ...",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0,
                        ),
                      ),
                      onFieldSubmitted: (value) =>
                          controller.updateSearch(value),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .where(
                      "owner_id",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return const Text("Error");
                  // ignore: unnecessary_null_comparison
                  if (snapshot.hasData == null) return Container();
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Text("No data!");
                  }
                  final data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.docs.length,
                    padding: EdgeInsets.zero,
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item =
                          (data.docs[index].data() as Map<String, dynamic>);
                      item["id"] = data.docs[index].id;

                      if (controller.search.isNotEmpty) {
                        var search = controller.search.toLowerCase();
                        var productName =
                            item["product_name"].toString().toLowerCase();
                        if (!productName.contains(search)) {
                          return Container();
                        }
                      }

                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: NetworkImage(
                              item["photo"] ?? "",
                            ),
                          ),
                          title: Text(item["product_name"]),
                          subtitle: Text(
                              "Rp ${NumberFormat.decimalPattern().format(item["price"])}"),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  backgroundColor: decreaseColor,
                                  radius: 12,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () =>
                                          controller.decreaseQty(item),
                                      icon: Icon(
                                        Icons.remove,
                                        color: primaryTextColor,
                                        size: 9,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${controller.getQty(item)}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: increaseColor,
                                  radius: 12,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () =>
                                          controller.increaseQty(item),
                                      icon: Icon(
                                        Icons.add,
                                        color: primaryTextColor,
                                        size: 9.0,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: usedColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Total :",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Text(
                    "Rp ${NumberFormat.decimalPattern().format(controller.total)}",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 72,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              onPressed: () => controller.checkout(),
              child: const Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<PosOrderView> createState() => PosOrderController();
}
