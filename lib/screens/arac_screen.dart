import 'package:co2_salinim/components/default_app_button.dart';
import 'package:co2_salinim/components/default_dropdown_button.dart';
import 'package:co2_salinim/components/default_scaffold.dart';
import 'package:co2_salinim/components/default_text_form_field.dart';
import 'package:co2_salinim/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AracScreen extends StatefulWidget {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  _AracScreenState createState() => _AracScreenState();
}

class _AracScreenState extends State<AracScreen> {
  UserData userData;
  String arac_ismi;
  String kat_edilen_mesafe;
  String yakit_turu;

  @override
  void initState() {
    userData = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: "Add Car",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: widget._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DefaultDropDownButton(
                hintText: "Fuel Type",
                items: userData.aracDataTypeDetailValues.keys.toList(),
                onChanged: (dynamic str) => this.setState(() => yakit_turu = str),
              ),
              SizedBox(height: 60),
              DefaultTextFormField(
                  keyboardType: TextInputType.text,
                  labelText: "Entry Name",
                  onChanged: (String str) {
                    setState(() {
                      arac_ismi = str;
                    });
                  }),
              SizedBox(height: 60),
              DefaultTextFormField(
                  keyboardType: TextInputType.number,
                  labelText: "Distance Traveled",
                  helperText: "Please insert in km",
                  suffixText: "KM",
                  onChanged: (String str) {
                    setState(() {
                      kat_edilen_mesafe = str;
                    });
                  }),
              SizedBox(height: 40),
              DefaultAppButton(
                  text: "Save",
                  onTap: () {
                    userData.addUserData(DataModel(
                      title: this.arac_ismi,
                      dataType: DataType.Car,
                      dataTypeDetail: userData.aracDataTypeDetailValues[yakit_turu],
                      value: int.parse(this.kat_edilen_mesafe), // calculate here
                    ));
                    Navigator.popUntil(context, ModalRoute.withName('/ekle'));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
