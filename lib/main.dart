import 'package:co2_salinim/screens/agac_screen.dart';
import 'package:co2_salinim/screens/arac_screen.dart';
import 'package:co2_salinim/screens/chart_screen.dart';
import 'package:co2_salinim/screens/yakit_screen.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CO2 Emissions',
      theme: ThemeData(
        fontFamily: 'Arial',
        primaryColor: Color(0xFF8BC34A),
        buttonColor: Color(0xFFFF9800),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color(0xFFFF9800)),
        textTheme: TextTheme(
          subhead: TextStyle(fontSize: 23),
          button: TextStyle(fontSize: 20)
        ),
      ),
      routes: {
        '/': (context) => ChartScreen(),
        '/arac-girisi': (context) => AracScreen(),
        '/yakit-girisi': (context) => YakitScreen(),
        '/agac-girisi': (context) => AgacScreen(),
      },
    );
  }
}
