import 'package:co2_salinim/components/default_app_button.dart';
import 'package:co2_salinim/components/default_dropdown_button.dart';
import 'package:co2_salinim/components/default_scaffold.dart';
import 'package:co2_salinim/components/default_text_form_field.dart';
import 'package:co2_salinim/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YakitScreen extends StatefulWidget {
  @override
  _YakitScreenState createState() => _YakitScreenState();
}

class _YakitScreenState extends State<YakitScreen> {
  UserData userData;
  String yakitIsmi;
  String tuketilenYakit;
  String yakitTuru;

  @override
  void initState() {
    userData = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: "Add Fuel",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DefaultTextFormField(
              keyboardType: TextInputType.text,
              labelText: "Entry Name",
              onChanged: (String str) => setState(() => yakitIsmi = str),
            ),
            SizedBox(height: 40),
            DefaultDropDownButton(
              hintText: "Fuel Type",
              items: userData.yakitDataTypeDetailValues.keys.toList(),
              onChanged: (dynamic str) => this.setState(() => yakitTuru = str),
            ),
            SizedBox(height: 40),
            DefaultTextFormField(
              keyboardType: TextInputType.number,
              labelText: "Amount of Fuel Used",
              onChanged: (String str) => setState(() => tuketilenYakit = str),
            ),
            SizedBox(height: 40),
            DefaultAppButton(
              text: "Save",
              onTap: () {
                userData.addUserData(DataModel(
                  title: this.yakitIsmi,
                  dataType: DataType.Build,
                  dataTypeDetail: userData.yakitDataTypeDetailValues[yakitTuru],
                  value: int.parse(this.tuketilenYakit), // calculate here
                ));
                Navigator.popUntil(context, ModalRoute.withName('/ekle'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
