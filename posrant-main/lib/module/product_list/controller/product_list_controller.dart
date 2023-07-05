import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posrant/service/product_service/product_service.dart';
import 'package:posrant/shared/util/show_loading/show_loading.dart';
import 'package:posrant/state_util.dart';
import '../view/product_list_view.dart';

class ProductListController extends State<ProductListView>
    implements MvcController {
  static late ProductListController instance;
  late ProductListView view;

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
      msg: 'Product deleted successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
    );
  }

  void _showErrorMessage() {
    Fluttertoast.showToast(
      msg: 'Failed to delete product',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  doDelete(String id) async {
    showLoading();
    bool success = await ProductService().delete(id);
    hideLoading();
    if (success) {
      _showSuccessMessage();
      Get.to(const ProductListView());
    } else {
      _showErrorMessage();
      Get.back();
    }
  }

  String search = "";
  updateSearch(String query) {
    search = query;
    setState(() {});
  }
}
