import 'package:co2_salinim/components/default_chart.dart';
import 'package:co2_salinim/components/default_floating_action_button.dart';
import 'package:co2_salinim/components/default_scaffold.dart';
import 'package:co2_salinim/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, UserData userData, _) => DefaultScaffold(
        buttonType: DefaultFloationActionButtonType.Add,
        title: "Ana Sayfa",
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
                height: 200,
                child: userData.getUserDatas.isEmpty ?  Text("Lütfen Veri Giriniz") : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: DefaultChart(userData.dataTypeChart()),
                          width: 300,
                        ),
                        Container(width: 1,color: Colors.green),
                        Container(
                          child:  DefaultChart(userData.dataTypeDetailChart()),
                          width: 300,
                        ),
                        Container(width: 1,color: Colors.green),
                        Container(
                          child:  DefaultChart(userData.pollutionChart()),
                          width: 300,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
