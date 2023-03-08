import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/core/enums/viewstate.dart';
import 'package:moneymanager/ui/shared/dimensions/dimensions.dart';
import 'package:moneymanager/ui/views/base_view.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../views/piechart_model.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PieChartModel>(
      model: PieChartModel(),
      onModelReady: (model) => model.init(true),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Chart'),
        ),
        body: model.state == ViewState.Busy
            ? CircularProgressIndicator()
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      width: Constants.screenWidth,
                      child: Column(
                        children: <Widget>[
                          ChipsChoice<int>.single(
                            choiceStyle: C2ChipStyle.filled(
                                backgroundOpacity: 0,
                                pressedStyle: const C2ChipStyle(
                                  backgroundColor: Colors.white,
                                  shadowColor: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                selectedStyle: const C2ChipStyle(
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.red,
                                  borderWidth: 2,
                                  borderStyle: BorderStyle.solid,
                                  borderOpacity: 0.9,
                                  checkmarkColor: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                checkmarkStyle: C2ChipCheckmarkStyle.round,
                                avatarForegroundColor: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                avatarForegroundStyle: TextStyle(color: Colors.red),
                                avatarBackgroundColor: Colors.red,
                                checkmarkColor: Colors.red),
                            choiceCheckmark: true,
                            value: model.selectedMonthIndex,
                            wrapped: true,
                            choiceItems: C2Choice.listFrom<int, String>(
                              source: model.months,
                              value: (i, v) => i,
                              label: (i, v) => v,
                            ),
                            onChanged: (val) => model.changeSelectedMonth(val),
                          ),
                          ChipsChoice<int>.single(
                            value: model.type == 'income' ? 0 : 1,
                            wrapped: true,
                            choiceCheckmark: true,
                            choiceItems: C2Choice.listFrom<int, String>(
                              source: model.types,
                              value: (i, v) => i,
                              label: (i, v) => v,
                            ),
                            onChanged: (val) => model.changeType(val),
                          ),
                          model.dataMap.length == 0 ? Text('No Data for this month') : PieChart(dataMap: model.dataMap),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
