import 'package:co2_salinim/screens/agac_screen.dart';
import 'package:co2_salinim/screens/arac_screen.dart';
import 'package:co2_salinim/screens/chart_screen.dart';
import 'package:co2_salinim/screens/ekle_screen.dart';
import 'package:co2_salinim/screens/yakit_screen.dart';
import 'package:co2_salinim/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeDat blackTheme = ThemeDat(
      themeData: ThemeData(
        fontFamily: 'Arial',
        primaryColor: Color(0xFF707070),
        buttonColor: Colors.white,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFF707070)),
        textTheme: TextTheme(
            subhead: TextStyle(fontSize: 23), button: TextStyle(fontSize: 20)),
      ),
      dataTypeColors: {
        DataType.Build: Colors.grey.shade100,
        DataType.Car: Colors.grey.shade200,
        DataType.Tree: Colors.grey.shade300,
      },
      dataTypeDetailColors: {
        DataTypeDetail.Benzin: Colors.grey.shade100,
        DataTypeDetail.Dizel: Colors.grey.shade200,
        DataTypeDetail.Dogalgaz: Colors.grey.shade300,
        DataTypeDetail.Elektrik: Colors.grey.shade400,
        DataTypeDetail.Hibrit: Colors.grey.shade500,
        DataTypeDetail.Komur: Colors.grey.shade600,
        DataTypeDetail.LPG: Colors.grey.shade700,
      },
      salinimTypeColors: {
        SalinimType.Emilim: Color(0xFFBEF67A),
        SalinimType.Salinim: Color(0xFF808080)
      });

  final ThemeDat greenTheme = ThemeDat(
      themeData: ThemeData(
        fontFamily: 'Arial',
        primaryColor: Color(0xFF8BC34A),
        buttonColor: Color(0xFFFF9800),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFFFF9800)),
        textTheme: TextTheme(
            subhead: TextStyle(fontSize: 23), button: TextStyle(fontSize: 20)),
      ),
      dataTypeColors: {
        DataType.Build: Colors.grey.shade100,
        DataType.Car: Colors.grey.shade200,
        DataType.Tree: Colors.grey.shade300,
      },
      dataTypeDetailColors: {
        DataTypeDetail.Benzin: Colors.grey.shade100,
        DataTypeDetail.Dizel: Colors.grey.shade200,
        DataTypeDetail.Dogalgaz: Colors.grey.shade300,
        DataTypeDetail.Elektrik: Colors.grey.shade400,
        DataTypeDetail.Hibrit: Colors.grey.shade500,
        DataTypeDetail.Komur: Colors.grey.shade600,
        DataTypeDetail.LPG: Colors.grey.shade700,
      },
      salinimTypeColors: {
        SalinimType.Emilim: Color(0xFFBEF67A),
        SalinimType.Salinim: Color(0xFFE0E0E0)
      });

  ThemeDat calculateCurrentTheme(UserData userData) {
    var x = userData.emilimHesapla();
    if (x.containsKey(SalinimType.Salinim) &&
        !x.containsKey(SalinimType.Emilim)) return blackTheme;
    if (!x.containsKey(SalinimType.Salinim) &&
        x.containsKey(SalinimType.Emilim)) return greenTheme;
    if (x.keys.length < 2) return greenTheme;
    return x[SalinimType.Salinim] - x[SalinimType.Emilim] > 0
        ? blackTheme
        : greenTheme;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserData>(
            create: (BuildContext context) => UserData()),
        ProxyProvider<UserData, ThemeDat>(
            update: (BuildContext _, UserData userData, __) =>
                calculateCurrentTheme(userData))
      ],
      child: Consumer<ThemeDat>(
        builder: (BuildContext context, ThemeDat themeData, _) => MaterialApp(
          title: 'CO2 Salinim',
          theme: themeData.themeData,
          routes: {
            '/': (context) => ChartScreen(),
            '/ekle': (context) => EkleScreen(),
            '/arac-girisi': (context) => AracScreen(),
            '/yakit-girisi': (context) => YakitScreen(),
            '/agac-girisi': (context) => AgacScreen(),
          },
        ),
      ),
    );
  }
}

class ThemeDat {
  final ThemeData themeData;
  final Map<DataType, Color> dataTypeColors;
  final Map<DataTypeDetail, Color> dataTypeDetailColors;
  final Map<SalinimType, Color> salinimTypeColors;
  ThemeDat(
      {this.themeData,
      this.dataTypeColors,
      this.dataTypeDetailColors,
      this.salinimTypeColors});
}
