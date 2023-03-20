import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moneymanager/core/models/transaction.dart';
import 'package:moneymanager/core/services/transaction_sercvices.dart';
import 'package:moneymanager/core/viewmodels/base_model.dart';

class InsertTransactionModel extends BaseModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  var user = GetStorage().read("user");
  bool loading = false;
  List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  String selectedDay = new DateTime.now().day.toString();
  String selectedMonth = new DateTime.now().day.toString();
  DateTime selectedDate = new DateTime.now();
  String type = "";
  int cateogryIndex = 1;

  Future selectDate(context) async {
    // hide the keyboard
    unFocusFromTheTextField(context);

    DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2020), lastDate: DateTime.now());

    if (picked != null) {
      selectedMonth = months[picked.month - 1];
      selectedDay = picked.day.toString();
      selectedDate = picked;

      notifyListeners();
    }
  }

  void init(int selectedCategory, int index) {
    // initla values are current day and month
    selectedMonth = months[DateTime.now().month - 1];
    selectedDay = DateTime.now().day.toString();
    type = (selectedCategory == 1) ? 'income' : 'expense';
    cateogryIndex = index;
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String getSelectedDate() {
    if (int.parse(selectedDay) == DateTime.now().day && DateTime.now().month == months.indexOf(selectedMonth) + 1) {
      return selectedMonth + ',' + selectedDay;
    } else {
      return selectedMonth + ',' + selectedDay;
    }
  }

  addTransaction(context) async {
    String memo = memoController.text;
    String amount = amountController.text;

    TransactionProcess newTransaction = TransactionProcess(
        type: type,
        day: selectedDay,
        month: selectedMonth,
        memo: memoController.text,
        amount: double.parse(amount),
        categoryindex: cateogryIndex);
    loading = true;
    notifyListeners();
    TransactionServices.addTransaction(newTransaction, user['uid']).then((value) {
      loading = false;
      memoController.clear();
      amountController.clear();
      notifyListeners();
    });
    Navigator.pop(context);
  }
}
