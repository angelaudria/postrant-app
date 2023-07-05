import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
// import 'package:posrant/service/dummy_service/dummy_service.dart';
// ignore: unnecessary_import
import '../controller/table_list_controller.dart';

class TableListView extends StatefulWidget {
  const TableListView({Key? key}) : super(key: key);

  Widget build(context, TableListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Table List"),
        actions: const [
          // IconButton(
          //   onPressed: () async {
          //     showLoading();
          //     await DummyService().generateTables();
          //     hideLoading();
          //   },
          //   icon: const Icon(
          //     Icons.refresh,
          //     size: 24,
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("tables")
                    .where(
                      "owner_id",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    .orderBy("order_index")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return const Text("Error");
                  if (snapshot.data == null) return Container();
                  if (snapshot.data!.docs.isEmpty) {
                    return const Text("No data!");
                  }

                  final data = snapshot.data!;

                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 8,
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: data.docs.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var item =
                          data.docs[index].data() as Map<String, dynamic>;

                      var used = item["status"] == "Used";

                      var color = primaryColor;

                      if (used) {
                        color = usedColor;
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item["table_number"],
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: primaryTextColor,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<TableListView> createState() => TableListController();
}
