import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanager/core/models/category.dart';
import 'package:moneymanager/core/viewmodels/insert_transaction_model.dart';
import 'package:moneymanager/ui/shared/app_colors.dart';
import 'package:moneymanager/ui/shared/ui_helpers.dart';
import 'package:moneymanager/ui/views/base_view.dart';

class InsertTranscationView extends StatelessWidget {
  final Category category;
  final int selectedCategory;
  InsertTranscationView({required this.category, required this.selectedCategory});
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<InsertTransactionModel>(
      model: InsertTransactionModel(),
      onModelReady: (model) => model.init(selectedCategory, category.index),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: selectedCategory == 1 ? Text('income'.tr) : Text('expense'.tr),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(category.name),
                    leading: CircleAvatar(
                        child: Icon(
                      category.icon,
                      size: 20,
                    )),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  buildTextField(model.memoController, 'label'.tr + " : ", "enter_label".tr, Icons.edit, false),
                  UIHelper.verticalSpaceMedium(),
                  buildTextField(model.amountController, 'amount'.tr + " : ", "enter_amount".tr, Icons.attach_money, true),
                  UIHelper.verticalSpaceMedium(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'select_date'.tr,
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    width: 20,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(model.getSelectedDate()),
                      onPressed: () async {
                        await model.selectDate(context);
                      },
                    ),
                  ),
                  UIHelper.verticalSpaceLarge(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: model.loading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
                            child: Text(
                              'add'.tr,
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                model.addTransaction(context);
                              }
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String text, String helperText, IconData icon, isNumeric) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "required_field".tr;
        }
      },
      cursorColor: Colors.black,
      maxLength: isNumeric ? 10 : 40,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}
