
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class UserData with ChangeNotifier {
  List<DataModel> _userDatas;

  final Map<String, DataTypeDetail> aracDataTypeDetailValues = {
    "LPG": DataTypeDetail.LPG,
    "Dizel": DataTypeDetail.Dizel,
    "Benzin": DataTypeDetail.Benzin,
    "Hibrit": DataTypeDetail.Hibrit,
  };

  final Map<String, DataTypeDetail> yakitDataTypeDetailValues = {
    "Doğalgaz": DataTypeDetail.Dogalgaz,
    "Kömür": DataTypeDetail.Komur,
    "Elektrik": DataTypeDetail.Elektrik,
  };

  Map<String, DataTypeDetail> get mergeDataTypeDetailValues => {
    ...aracDataTypeDetailValues,
    ...yakitDataTypeDetailValues
  };


  final Map<DataType, String> genelDataTypeValues = {
    DataType.Build: "Binalar",
    DataType.Car: "Arabalar",
    DataType.Tree: "Ağaçlar",
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

  List<charts.Series<MapEntry<DataType, int>, int>> dataTypeChart() {
    var g = getUserDatas
        .fold(Map<DataType, int>(), (Map<DataType, int> i, DataModel v) {
          if (v.dataType == DataType.Tree) return i;
          int a = i.putIfAbsent(v.dataType, () => 0);
          a += v.getCalculatedValue.toInt();
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
        data: g,
        labelAccessorFn: (MapEntry<DataType, int> row, _) => genelDataTypeValues[row.key],
      )
    ];
  }

  List<charts.Series<MapEntry<DataTypeDetail, int>, int>> dataTypeDetailChart() {
    var g = getUserDatas
        .fold(Map<DataTypeDetail, int>(), (Map<DataTypeDetail, int> i, DataModel v) {
          if (v.dataType == DataType.Tree) return i;
          int a = i.putIfAbsent(v.dataTypeDetail, () => 0);
          a += v.getCalculatedValue.toInt();
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
        data: g,
        labelAccessorFn: (MapEntry<DataTypeDetail, int> row, _) => mergeDataTypeDetailValues.keys.where((k) => mergeDataTypeDetailValues[k] == row.key).first,
      )
    ];
  }

    List<charts.Series<MapEntry<String, int>, int>> pollutionChart() {
    var g = getUserDatas
        .fold(Map<String, int>(), (Map<String, int> i, DataModel v) {
          String key = (v.dataType == DataType.Tree)  ? "Salınım" : "Emilim";
          int a = i.putIfAbsent(key, () => 0);
          a += v.getCalculatedValue.toInt();
          i[key] = a;
          return i;
        })
        .entries
        .toList();

    return [
      new charts.Series<MapEntry<String, int>, int>(
        id: 'chart1',
        domainFn: (MapEntry<String, int> entry, _) => g.map((k) => k.key).toList().indexOf(entry.key),
        measureFn: (MapEntry<String, int> entry, _) => entry.value.abs(),
        data: g,
        labelAccessorFn: (MapEntry<String, int> row, _) => row.key,
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
