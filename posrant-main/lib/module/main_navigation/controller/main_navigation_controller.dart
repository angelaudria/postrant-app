import 'package:flutter/material.dart';
import 'package:posrant/state_util.dart';
import '../view/main_navigation_view.dart';

class MainNavigationController extends State<MainNavigationView>
    implements MvcController {
  static late MainNavigationController instance;
  late MainNavigationView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  int selectedIndex = 0;
  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
  }

  // Tambahkan metode untuk mendapatkan jumlah pesanan dengan status "Paid"
  Stream<int> getOrderCountStreamByStatus(String status) {
    return view.orderService.getOrderCountStreamByStatus(status);
  }
}