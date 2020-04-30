import 'package:co2_salinim/components/default_chart.dart';
import 'package:co2_salinim/components/default_floating_action_button.dart';
import 'package:co2_salinim/components/default_scaffold.dart';
import 'package:co2_salinim/main.dart';
import 'package:co2_salinim/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatelessWidget {
  final ValueNotifier<chartTab> currentChart = ValueNotifier<chartTab>(chartTab.dataType);


  @override
  Widget build(BuildContext context) {
    ThemeDat themeDat = Provider.of<ThemeDat>(context);
    return Consumer<UserData>(
      builder: (context, UserData userData, _) => DefaultScaffold(
        buttonType: DefaultFloationActionButtonType.Add,
        title: "Home Page",
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 50),
              SizedBox(
                height: 150,
                child: userData.getUserDatas.isEmpty
                    ? Text("Please insert data")
                    : Stack(children: <Widget>[
                        SizedBox(height: 200),
                        ValueListenableBuilder(
                          builder: (BuildContext context, chartTab value, Widget _) {
                            Widget currentWidget;
                            switch (value) {
                              case chartTab.dataType:
                                currentWidget = DefaultChart(userData.dataTypeChart(themeDat));
                                break;
                              case chartTab.dataTypeDetail:
                                currentWidget = DefaultChart(userData.dataTypeDetailChart(themeDat));
                                break;
                              case chartTab.polluiton:
                                currentWidget = DefaultChart(userData.pollutionChart(themeDat));
                                break;
                            }
                            return currentWidget;
                          },
                          valueListenable: currentChart,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 30,
                          child: InkWell(
                            onTap: () {
                              switch (currentChart.value) {
                                case chartTab.dataType:
                                  currentChart.value = chartTab.dataTypeDetail;
                                  break;
                                case chartTab.dataTypeDetail:
                                  currentChart.value = chartTab.polluiton;
                                  break;
                                case chartTab.polluiton:
                                default:
                                  currentChart.value = chartTab.dataType;
                                  break;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.cached, size: 25),
                            ),
                          ),
                        ),
                        /* Positioned(
                          bottom: 90,
                          right: 30,
                          child: InkWell(
                            onTap: () {
                              userData.addUserData(DataModel(title: "Benzinli Araba", dataType: DataType.Car, dataTypeDetail: DataTypeDetail.Benzin, value: 1000));
                              userData.addUserData(DataModel(title: "Dizel Araba", dataType: DataType.Car, dataTypeDetail: DataTypeDetail.Dizel, value: 1500));
                              userData.addUserData(DataModel(title: "Kömürlü Ev", dataType: DataType.Build, dataTypeDetail: DataTypeDetail.Komur, value: 30));
                              userData.addUserData(DataModel(title: "Elektrikli Ev", dataType: DataType.Build, dataTypeDetail: DataTypeDetail.Elektrik, value: 30));
                              userData.addUserData(DataModel(title: "Doğalgazlı Ev", dataType: DataType.Build, dataTypeDetail: DataTypeDetail.Dogalgaz, value: 3000));
                              userData.addUserData(DataModel(title: "Ağaç", dataType: DataType.Tree, value: 3000));
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.add, size: 25),
                            ),
                          ),
                        ) */
                      ]),
              ),
              SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    //shrinkWrap: true,
                    children: userData.getUserDatas.map((DataModel d) => DataRow(dataModel: d)).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DataRow extends StatelessWidget {
  final DataModel dataModel;
  const DataRow({
    Key key,
    this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                color:  dataModel.dataType == DataType.Tree ? Colors.green : Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(dataModel.title ?? ""))
          ,
          Text("${dataModel.dataType == DataType.Tree ? "-" : ""} ${dataModel.getCalculatedValue.toStringAsFixed(2)} KG CO2",textAlign: TextAlign.right),
          SizedBox(width: 20)
        ],
      ),
    );
  }
}

enum chartTab { dataType, dataTypeDetail, polluiton }
