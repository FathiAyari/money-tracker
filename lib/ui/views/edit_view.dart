import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanager/core/models/transaction.dart';
import 'package:moneymanager/core/viewmodels/edit_model.dart';
import 'package:moneymanager/ui/shared/ui_helpers.dart';
import 'package:moneymanager/ui/views/base_view.dart';

import '../shared/app_colors.dart';

class EditView extends StatelessWidget {
  final TransactionProcess transaction;
  EditView(this.transaction);

  @override
  Widget build(BuildContext context) {
    return BaseView<EditModel>(
      model: EditModel(),
      onModelReady: (model) => model.init(transaction),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('edit'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(model.category.name),
                leading: CircleAvatar(
                    child: Icon(
                  model.category.icon,
                  size: 20,
                )),
              ),
              UIHelper.verticalSpaceMedium(),
              buildTextField(model.memoController, 'label'.tr + ' : ', "enter_label".tr, Icons.edit, false),
              UIHelper.verticalSpaceMedium(),
              buildTextField(model.amountController, 'amount'.tr + ' : ', "enter_amount".tr, Icons.attach_money, true),
              UIHelper.verticalSpaceMedium(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'select_date'.tr + ' : ',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                ),
              ),
              Divider(
                thickness: 2,
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
                  child: Text(
                    'edit'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  onPressed: () async {
                    await model.editTransaction(context, transaction);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String text, String helperText, IconData icon, isNumeric) {
    return TextFormField(
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
