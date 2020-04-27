import 'package:co2_salinim/components/default_chart.dart';
import 'package:co2_salinim/components/default_floating_action_button.dart';
import 'package:co2_salinim/components/default_scaffold.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: "Ana Sayfa",
      buttonType: DefaultFloationActionButtonType.Add,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: DefaultChart.withSampleData(),
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
