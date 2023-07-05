// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
import 'package:posrant/service/product_service/product_service.dart';
import 'package:posrant/shared/util/validator/validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductFormController extends State<ProductFormView>
    implements MvcController {
  static late ProductFormController instance;
  late ProductFormView view;

  @override
  void initState() {
    instance = this;
    if (isEdit) {
      id = widget.item!["id"];
      photo = widget.item!["photo"];
      productName = widget.item!["product_name"];
      price = widget.item!["price"].toDouble();
      category = widget.item!["category"];
      description = widget.item!["description"];
    }
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  bool get isEdit => widget.item != null;

  String? id;
  String? photo;
  String? productName;
  double? price;
  String? category;
  String? description;

  String? productNameError;
  String? photoError;
  String? priceError;
  String? categoryError;
  String? descriptionError;

  void _validateForm() {
    photoError = Validator.required(photo);
    productNameError = Validator.required(productName);
    priceError = Validator.required(price?.toString());
    categoryError = Validator.required(category);
    descriptionError = Validator.required(description);
  }

  void _clearErrors() {
    productNameError = null;
    priceError = null;
    categoryError = null;
    descriptionError = null;
  }

  void _showSuccessAdd() {
    Fluttertoast.showToast(
      msg: 'Product created successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
    );
  }

  void _showSuccessUpdate() {
    Fluttertoast.showToast(
      msg: 'Product update successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
    );
  }

  void _showErrorMessage() {
    Fluttertoast.showToast(
      msg: 'Failed to save product',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  bool _isValid() {
    return productNameError == null &&
        priceError == null &&
        categoryError == null &&
        descriptionError == null;
  }

  doSave() async {
    _clearErrors();
    _validateForm();
    if (_isValid()) {
      if (isEdit) {
        showLoading();
        bool success = await ProductService().update(
          id: id!,
          photo: photo!,
          productName: productName!,
          price: price!,
          category: category!,
          description: description!,
        );
        hideLoading();
        if (success) {
          _showSuccessUpdate();
          Get.to(const ProductListView());
        } else {
          _showErrorMessage();
          Get.back();
        }
      } else {
        showLoading();
        bool success = await ProductService().create(
          photo: photo!,
          productName: productName!,
          price: price!,
          category: category!,
          description: description!,
        );
        hideLoading();
        if (success) {
          _showSuccessAdd();
          Get.to(const ProductListView());
        } else {
          _showErrorMessage();
          Get.back();
        }
      }
    } else {
      setState(() {});
    }
  }
}
