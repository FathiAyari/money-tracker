import 'package:flutter/material.dart';
import 'package:moneymanager/core/services/category_icon_service.dart';
import 'package:moneymanager/core/viewmodels/base_model.dart';

import '../../locator.dart';
import '../models/transaction.dart';

class DetailsModel extends BaseModel {
  final CategoryIconService _categoryIconService = locator<CategoryIconService>();

  Icon getIconForCategory(int index, String type) {
    if (type == 'income') {
      final categoryIcon = _categoryIconService.incomeList.elementAt(index);

      return Icon(
        categoryIcon.icon,
        color: categoryIcon.color,
      );
    } else {
      final categoryIcon = _categoryIconService.expenseList.elementAt(index);

      return Icon(
        categoryIcon.icon,
        color: categoryIcon.color,
      );
    }
  }

  String getCategoryIconName(index, type) {
    if (type == 'income') {
      return _categoryIconService.incomeList.elementAt(index).name;
    } else {
      return _categoryIconService.expenseList.elementAt(index).name;
    }
  }

  Future deleteTransacation(TransactionProcess transaction) async {}
}
