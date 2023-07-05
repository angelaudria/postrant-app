import 'package:flutter/material.dart';
import 'package:posrant/core.dart';
import 'package:posrant/service/order_service/order_service.dart';

class MainNavigationView extends StatefulWidget {
  MainNavigationView({Key? key}) : super(key: key);

  final OrderService orderService =
      OrderService(); // Tambahkan properti orderService

  Widget build(context, MainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 4,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: const [
            DashboardView(),
            OrderView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: (newIndex) => controller.updateIndex(newIndex),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.viewDashboard,
              ),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: StreamBuilder<int>(
                  stream: controller.getOrderCountStreamByStatus("Pending"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
                child: const Icon(MdiIcons.table),
              ),
              label: "Order",
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "User",
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<MainNavigationView> createState() => MainNavigationController();
}
