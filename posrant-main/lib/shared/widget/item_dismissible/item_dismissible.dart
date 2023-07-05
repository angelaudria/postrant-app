import 'package:flutter/material.dart';
import 'package:posrant/core.dart';

class ItemDismissible extends StatelessWidget {
  final Widget child;
  final Function onConfirm;
  final Function? onCancel;

  const ItemDismissible({
    super.key,
    required this.child,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (detail) {},
      confirmDismiss: (direction) async {
        bool confirm = false;
        await showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm !'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Are you sure you want to delete this item?'),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    confirm = true;
                    Navigator.pop(context);
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
        if (confirm) {
          onConfirm();
          return Future.value(true);
        }
        if (onCancel != null) onCancel!();
        return Future.value(false);
      },
      child: child,
    );
  }
}
