import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionTypeSpinner extends StatelessWidget {
  final selectedItem;
  final Function changedSelectedItem;
  const TransactionTypeSpinner(this.selectedItem, this.changedSelectedItem);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedItem,
        items: [
          DropdownMenuItem(
            child: Text("income".tr),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text("expense".tr),
            value: 2,
          ),
        ],
        onChanged: (value) {
          changedSelectedItem(value);
        });
  }
}
