import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/core/enums/viewstate.dart';
import 'package:moneymanager/core/viewmodels/home_model.dart';
import 'package:moneymanager/ui/shared/app_colors.dart';
import 'package:moneymanager/ui/views/base_view.dart';
import 'package:moneymanager/ui/widgets/home_view_widgets/app_bar_title_widget.dart';
import 'package:moneymanager/ui/widgets/home_view_widgets/app_drawer.dart';
import 'package:moneymanager/ui/widgets/home_view_widgets/app_fab.dart';
import 'package:moneymanager/ui/widgets/home_view_widgets/empty_transaction_widget.dart';
import 'package:moneymanager/ui/widgets/home_view_widgets/month_year_picker_widget.dart';
import 'package:moneymanager/ui/widgets/home_view_widgets/summary_widget.dart';
import 'package:moneymanager/ui/widgets/home_view_widgets/transactions_listview_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("Do you want to leave ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            "Yes",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text("No"));
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      model: HomeModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: avoidReturnButton,
        child: Scaffold(
          appBar: buildAppBar(model.appBarTitle, model),
          drawer: AppDrawer(context),
          floatingActionButton: Visibility(
            visible: model.show,
            child: AppFAB(model.closeMonthPicker),
          ),
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SummaryWidget(
                          income: model.incomeSum,
                          expense: model.expenseSum,
                        ),
                        buildList(model),
                      ],
                    ),
                    model.isCollabsed
                        ? PickMonthOverlay(model: model, showOrHide: model.isCollabsed, context: context)
                        : Container(),
                  ],
                ),
        ),
      ),
    );
  }

  buildAppBar(String title, HomeModel model) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: backgroundColor,
      title: AppBarTitle(
        title: title,
        model: model,
      ),
    );
  }

  buildList(HomeModel model) {
    return model.transactions.length == 0 ? EmptyTransactionsWidget() : TransactionsListView(model.transactions, model);
  }
}
