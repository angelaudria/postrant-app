import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
import 'package:posrant/module/dashboard/widget/dashboard_banner_image.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  Widget build(context, DashboardController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DashboardBannerImage(), // widget
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'All featured', // Add the desired text
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Builder(
                builder: (context) {
                  List<Map<String, dynamic>> items = [
                    {
                      "icon": "assets/images/fast-food.png",
                      "label": "Product",
                      "on_tap": () => Get.to(const ProductListView()),
                    },
                    {
                      "icon": "assets/images/table.png",
                      "label": "Table",
                      "on_tap": () => Get.to(const TableListView()),
                    },
                    {
                      "icon": "assets/images/point-of-sale.png",
                      "label": "POS",
                      "on_tap": () => Get.to(const PosTableView()),
                    },
                    {
                      "icon": "assets/images/cashless-payment.png",
                      "label": "Order",
                      "on_tap": () => Get.to(const OrderView()),
                    },
                  ];
                  return Column(
                    children: items
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () => item["on_tap"](),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      Image(
                                        image: AssetImage(item["icon"]),
                                        width: 32,
                                        height: 32,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          item["label"],
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(Icons.arrow_forward),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
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
  State<DashboardView> createState() => DashboardController();
}
