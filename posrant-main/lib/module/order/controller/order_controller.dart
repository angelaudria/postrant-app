import 'package:flutter/material.dart';
import 'package:posrant/service/order_service/order_service.dart';
import 'package:posrant/shared/util/show_loading/show_loading.dart';
import 'package:posrant/state_util.dart';
import '../view/order_view.dart';

class OrderController extends State<OrderView> implements MvcController {
  static late OrderController instance;
  late OrderView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  updateStatusToPaid({
    required String orderId,
    required String tableNumber,
  }) async {
    showLoading();
    await OrderService().setOrderPaid(
      orderId: orderId,
      tableNumber: tableNumber,
    );
    hideLoading();
  }

  String status = "Pending";
  updateStatus(newStatus) {
    status = newStatus;
    setState(() {});
  }
}
