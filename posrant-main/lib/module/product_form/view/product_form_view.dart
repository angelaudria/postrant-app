// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
import 'package:posrant/shared/util/validator/validator.dart';
import '../controller/product_form_controller.dart';

class ProductFormView extends StatefulWidget {
  final Map? item;
  const ProductFormView({Key? key, this.item}) : super(key: key);

  Widget build(context, ProductFormController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Form"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      QImagePicker(
                        label: "Photo",
                        hint: "Your photo",
                        value: controller.photo,
                        onChanged: (value) {
                          controller.photo = value;
                        },
                      ),
                      if (controller.photoError != null)
                        Text(
                          controller.photoError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      QTextField(
                        label: "Product name",
                        validator: Validator.required,
                        value: controller.productName,
                        onChanged: (value) {
                          controller.productName = value;
                        },
                      ),
                      if (controller.productNameError != null)
                        Text(
                          controller.productNameError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      QNumberField(
                        label: "Price",
                        validator: Validator.required,
                        // ignore: prefer_null_aware_operators
                        value: controller.price != null
                            ? NumberFormat.decimalPattern()
                                .format(controller.price)
                            : null,
                        onChanged: (value) {
                          controller.price = double.tryParse(value);
                        },
                      ),
                      if (controller.priceError != null)
                        Text(
                          controller.priceError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      QDropdownField(
                        label: "Category",
                        validator: Validator.required,
                        value: controller.category,
                        items: const [
                          {
                            "label": "Tea",
                            "value": "Tea",
                          },
                          {
                            "label": "Cocktails",
                            "value": "Cocktails",
                          },
                          {
                            "label": "Beer",
                            "value": "Beer",
                          },
                          {
                            "label": "Mineral Water",
                            "value": "Mineral Water",
                          },
                          {
                            "label": "Juices",
                            "value": "Juices",
                          },
                          {
                            "label": "Coffee",
                            "value": "Coffee",
                          },
                          {
                            "label": "Beverages",
                            "value": "Beverages",
                          },
                          {
                            "label": "Pasta",
                            "value": "Pasta",
                          },
                          {
                            "label": "Rice/Noodles",
                            "value": "Rice/Noodles",
                          },
                          {
                            "label": "Appetizers",
                            "value": "Appetizers",
                          },
                          {
                            "label": "Soups",
                            "value": "Soups",
                          },
                          {
                            "label": "Salads",
                            "value": "Salads",
                          },
                          {
                            "label": "Main Courses",
                            "value": "Main Courses",
                          },
                          {
                            "label": "Seafood",
                            "value": "Seafood",
                          },
                          {
                            "label": "Sides/Snacks",
                            "value": "Sides/Snacks",
                          },
                          {
                            "label": "Beef",
                            "value": "Beef",
                          },
                          {
                            "label": "Desserts",
                            "value": "Desserts",
                          },
                        ],
                        onChanged: (value, label) {
                          controller.category = value;
                        },
                      ),
                      if (controller.categoryError != null)
                        Text(
                          controller.categoryError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      QMemoField(
                        label: "Description",
                        validator: Validator.required,
                        value: controller.description,
                        onChanged: (value) {
                          controller.description = value;
                        },
                      ),
                      if (controller.descriptionError != null)
                        Text(
                          controller.descriptionError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 72,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
          ),
          onPressed: () => controller.doSave(),
          child: const Text("Save"),
        ),
      ),
    );
  }

  @override
  State<ProductFormView> createState() => ProductFormController();
}
