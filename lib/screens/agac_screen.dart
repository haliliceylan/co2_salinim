import 'package:co2_salinim/components/default_app_button.dart';
import 'package:co2_salinim/components/default_scaffold.dart';
import 'package:co2_salinim/components/default_text_form_field.dart';
import 'package:co2_salinim/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgacScreen extends StatefulWidget {
  @override
  _AgacScreenState createState() => _AgacScreenState();
}

class _AgacScreenState extends State<AgacScreen> {
  UserData userData;
  String agacIsmi;
  String agacSayisi;

  @override
  void initState() {
    userData = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: "Agaç Girişi",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //DefaultDropDownButton(hintText: "Yakıt Türü", items: ["Doğalgaz", "Kömür", "Elektrik"]),
            DefaultTextFormField(keyboardType: TextInputType.text, labelText: "Ağaç İsmi", onChanged: (String str) => setState(() => agacIsmi = str)),
            SizedBox(height: 60),
            DefaultTextFormField(keyboardType: TextInputType.text, labelText: "Ağaç Sayısı", onChanged: (str) => this.setState(() => agacSayisi = str)),
            SizedBox(height: 60),
            DefaultAppButton(
              text: "Kaydet",
              onTap: () {
                userData.addUserData(DataModel(
                  title: this.agacIsmi,
                  dataType: DataType.Tree,
                  value: int.parse(this.agacSayisi), // calculate here
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
