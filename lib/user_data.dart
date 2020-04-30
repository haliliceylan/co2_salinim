import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import 'main.dart';

class UserData with ChangeNotifier {
  List<DataModel> _userDatas;

  final Map<String, DataTypeDetail> aracDataTypeDetailValues = {
   // "LPG": DataTypeDetail.LPG,
    "Diesel": DataTypeDetail.Dizel,
    "Gasoline": DataTypeDetail.Benzin,
   // "Hibrit": DataTypeDetail.Hibrit,
  };

  final Map<String, DataTypeDetail> yakitDataTypeDetailValues = {
    "Natural gas": DataTypeDetail.Dogalgaz,
    "Coal": DataTypeDetail.Komur,
    "Electricity": DataTypeDetail.Elektrik,
  };
  charts.Color _convertColor(Color color) => charts.Color(r: color.red, g: color.green, b: color.blue);
  Map<String, DataTypeDetail> get mergeDataTypeDetailValues => {...aracDataTypeDetailValues, ...yakitDataTypeDetailValues};

  final Map<DataType, String> genelDataTypeValues = {
    DataType.Build: "Buildings",
    DataType.Car: "Cars",
    DataType.Tree: "Trees",
  };

  UserData() {
    _userDatas = new List<DataModel>();
  }

  List<DataModel> get getUserDatas => _userDatas;

  void addUserData(dynamic asd) {
    _userDatas.add(asd);
    notifyListeners();
  }

  void removeUserData(int i) {
    _userDatas.removeAt(i);
    notifyListeners();
  }

  List<charts.Series<MapEntry<DataType, int>, int>> dataTypeChart(ThemeDat themeDat) {
    int total = 0;
    var g = getUserDatas
        .fold(Map<DataType, int>(), (Map<DataType, int> i, DataModel v) {
          if (v.dataType == DataType.Tree) return i;
          int a = i.putIfAbsent(v.dataType, () => 0);
          a += v.getCalculatedValue.toInt();
          total += v.getCalculatedValue.toInt();
          i[v.dataType] = a;
          return i;
        })
        .entries
        .toList();

    return [
      new charts.Series<MapEntry<DataType, int>, int>(
        id: 'chart1',
        domainFn: (MapEntry<DataType, int> entry, _) => g.map((k) => k.key).toList().indexOf(entry.key),
        measureFn: (MapEntry<DataType, int> entry, _) => entry.value.abs(),
        colorFn: (v, i){
          return _convertColor(themeDat.dataTypeColors[v.key]);
        },
        data: g,
        labelAccessorFn: (MapEntry<DataType, int> row, _) => "${genelDataTypeValues[row.key]} %${(row.value/total * 100).toInt()}",
      )
    ];
  }

  List<charts.Series<MapEntry<DataTypeDetail, int>, int>> dataTypeDetailChart(ThemeDat themeDat) {
    int total = 0;
    var g = getUserDatas
        .fold(Map<DataTypeDetail, int>(), (Map<DataTypeDetail, int> i, DataModel v) {
          if (v.dataType == DataType.Tree) return i;
          int a = i.putIfAbsent(v.dataTypeDetail, () => 0);
          a += v.getCalculatedValue.toInt();
          total += v.getCalculatedValue.toInt();
          i[v.dataTypeDetail] = a;
          return i;
        })
        .entries
        .toList();
    print(g);
    return [
      new charts.Series<MapEntry<DataTypeDetail, int>, int>(
        id: 'chart1',
        domainFn: (MapEntry<DataTypeDetail, int> entry, _) => g.map((k) => k.key).toList().indexOf(entry.key),
        measureFn: (MapEntry<DataTypeDetail, int> entry, _) => entry.value.abs(),
        colorFn: (v, i) => _convertColor(themeDat.dataTypeDetailColors[v.key]),
        data: g,
        labelAccessorFn: (MapEntry<DataTypeDetail, int> row, _) => "${mergeDataTypeDetailValues.keys.where((k) => mergeDataTypeDetailValues[k] == row.key).first} %${(row.value/total * 100).toInt()}",
      )
    ];
  }

  Map<SalinimType, int> emilimHesapla(){
    return getUserDatas
        .fold(Map<SalinimType, int>(), (Map<SalinimType, int> i, DataModel v) {
          var key = (v.dataType != DataType.Tree) ? SalinimType.Salinim : SalinimType.Emilim;
          int a = i.putIfAbsent(key, () => 0);
          a += v.getCalculatedValue.toInt();
          i[key] = a;
          return i;
        });
  }
  List<charts.Series<MapEntry<SalinimType, int>, int>> pollutionChart(ThemeDat themeDat) {
    int total = 0;
    var a = emilimHesapla();

    a.forEach((SalinimType s,int a) => total += a);

    var g = a.entries
        .toList();

    return [
      new charts.Series<MapEntry<SalinimType, int>, int>(
        id: 'chart1',
        domainFn: (MapEntry<SalinimType, int> entry, _) => g.map((k) => k.key).toList().indexOf(entry.key),
        measureFn: (MapEntry<SalinimType, int> entry, _) => entry.value.abs(),
        colorFn: (v, i) => _convertColor(themeDat.salinimTypeColors[v.key]),
        data: g,
        labelAccessorFn: (MapEntry<SalinimType, int> row, _) => "${row.key.name} %${(row.value/total * 100).toInt()}",
      )
    ];
  }
}

class DataModel {
  final String title;
  final int value;
  final DataType dataType;
  final DataTypeDetail dataTypeDetail;

  double get getCalculatedValue {
    double calculatedVal = this.value.toDouble();
    switch (dataType) {
      case DataType.Tree:
        calculatedVal *= 2.3;
        break;
      case DataType.Build:
      case DataType.Car:
        switch (dataTypeDetail) {
          case DataTypeDetail.Elektrik:
            calculatedVal *= 0.43;
            break;
          case DataTypeDetail.Dogalgaz:
            calculatedVal *= 2.18;
            break;
          case DataTypeDetail.Komur:
            calculatedVal *= 2.93;
            break;
          case DataTypeDetail.Benzin:
            calculatedVal /= 13;
            calculatedVal *= 2.33;
            break;
          case DataTypeDetail.Dizel:
            calculatedVal /= 17;
            calculatedVal *= 2.77;
            break;
          default:
            calculatedVal *= 0;
            break;
        }
        break;
    }
    return calculatedVal;
  }

  DataModel({this.title, this.value, this.dataType, this.dataTypeDetail});
}

enum DataType { Tree, Car, Build }

enum DataTypeDetail { LPG, Dizel, Benzin, Hibrit, Dogalgaz, Komur, Elektrik }

enum SalinimType {
  Salinim, Emilim
}

extension SalinimTypeExtension on SalinimType {

  String get name {
    switch (this) {
      case SalinimType.Salinim:
        return 'Osci...';
      case SalinimType.Emilim:
        return 'Absor...';
      default:
        return null;
    }
  }

  void talk() {
    print('meow');
  }
}