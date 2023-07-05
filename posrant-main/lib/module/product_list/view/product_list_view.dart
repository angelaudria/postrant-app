// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
import 'package:posrant/shared/widget/item_dismissible/item_dismissible.dart';
// ignore: unnecessary_import
import '../controller/product_list_controller.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  Widget build(context, ProductListController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Get.to(const ProductFormView());
        },
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
                  if (snapshot.hasData == null) return Container();
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Text("No data");
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

                      return ItemDismissible(
                        onConfirm: () => controller.doDelete(item["id"]),
                        child: Card(
                          child: ListTile(
                            onTap: () async {
                              await Get.to(
                                ProductFormView(
                                  item: item,
                                ),
                              );
                            },
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    item["photo"] ?? "",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                            title: Text(item["product_name"] ?? ""),
                            subtitle: Text(
                              "Rp ${NumberFormat.decimalPattern().format(item["price"])}",
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
    );
  }

  @override
  State<ProductListView> createState() => ProductListController();
}
