import 'package:co2_salinim/components/default_button.dart';
import 'package:co2_salinim/components/default_scaffold.dart';
import 'package:flutter/material.dart';

class EkleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: "Add New Entry",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 60),
              DefaultButton(
                  title: "Add Car",
                  assetUrl: "assets/car_button.png",
                  routeName: "/arac-girisi"),
              SizedBox(height: 60),
              DefaultButton(
                  title: "Add Building",
                  assetUrl: "assets/fire_button.png",
                  routeName: "/yakit-girisi"),
              SizedBox(height: 60),
              DefaultButton(
                  title: "Add Tree",
                  assetUrl: "assets/tree_button.png",
                  routeName: "/agac-girisi"),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
