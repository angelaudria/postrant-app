import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posrant/core.dart';
import 'package:posrant/service/order_service/order_service.dart';

class PosOrderController extends State<PosOrderView> implements MvcController {
  static late PosOrderController instance;
  late PosOrderView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  void _showSuccessMessage() {
    Fluttertoast.showToast(
      msg: 'Order successfully created',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
    );
  }

  void _showErrorMessage(String errorMessage) {
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  String search = "";

  updateSearch(String query) {
    search = query;
    setState(() {});
  }

  List productList = [];

  getQty(item) {
    var index = productList.indexWhere((i) => i["id"] == item["id"]);

    if (index > -1) {
      productList[index]["qty"] ??= 0;
      return productList[index]["qty"];
    }

    return 0;
  }

  increaseQty(item) {
    addProductIfNotFound(item);

    var index = productList.indexWhere((i) => i["id"] == item["id"]);

    if (index > -1) {
      productList[index]["qty"] ??= 0;
      productList[index]["qty"]++;
    }
    setState(() {});
  }

  decreaseQty(item) {
    addProductIfNotFound(item);

    var index = productList.indexWhere((i) => i["id"] == item["id"]);

    if (index > -1) {
      productList[index]["qty"] ??= 0;
      if (productList[index]["qty"] == 0) return;
      productList[index]["qty"]--;
    }
    setState(() {});
  }

  addProductIfNotFound(item) {
    var index = productList.indexWhere((i) => i["id"] == item["id"]);
    if (index == -1) {
      item["qty"] = 0;
      productList.add(item);
    }
  }

  double get total {
    double itemTotal = 0;
    for (var item in productList) {
      itemTotal += item["qty"] * item["price"];
    }
    return itemTotal;
  }

  checkout() async {
    if (productList.isEmpty) {
      // Menampilkan pesan validasi jika tidak ada item yang di-checkout
      String errorMessage = "Tidak ada item yang di checkout";
      _showErrorMessage(errorMessage);
      return;
    }

    showLoading();
    bool success = await OrderService().create(
      tableNumber: widget.tableNumber,
      items: productList,
      total: total,
      paymentMethod: "Cash",
      status: "Pending",
    );
    hideLoading();

    // ignore: unnecessary_null_comparison
    if (success != null && success) {
      showLoading();
      Get.offAll(MainNavigationView());
      hideLoading();
      _showSuccessMessage();
    } else {
      String errorMessage = 'Failed to create orders';
      Get.back();
      _showErrorMessage(errorMessage);
    }
  }
}
