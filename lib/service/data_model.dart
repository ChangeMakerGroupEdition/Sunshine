import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

List<String> yearRange = ["2016", "2017", "2018", "2019", "2020"];

// class DataModel {
//   final double dailyDNR;
//   final double dailyDIFF;
//   final String title;

//   DataModel({
//     required this.dailyDNR,
//     required this.dailyDIFF,
//     required this.title,
//   });

//   factory DataModel.fromJson(Map<String, dynamic> json, String date) {
//     return DataModel(
//       title: json['header']['title'],
//       dailyDNR: json['properties']['parameter']['ALLSKY_SFC_SW_DNI'][date],
//       dailyDIFF: json['properties']['parameter']['ALLSKY_SFC_SW_DIFF'][date]
//     );
//   }
// }

Future<YearRangeDataset> fetchFiveYearData() async{
  String cord = "latitude=3.1866&longitude=113.0403";
  String startDate = "2016";
  String endDate = "2020";
  final res = await http.get(Uri.parse('https://power.larc.nasa.gov/api/temporal/monthly/point?parameters=CLOUD_AMT,DNR,DIFF&community=SB&' + cord + '&start=' + startDate +  '&end=' + endDate + '&format=JSON'));
  if(res.statusCode==200){
    print(jsonDecode(res.body));
    return YearRangeDataset.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to load data.');
  }
}

class DataModel {
  final List<String> dates;
  final List<double> values;

  DataModel({
    required this.dates,
    required this.values
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    List<String> dates = [];
    List<double> values = [];
    json.forEach((key, value) { dates.add(key); values.add(value);});
    return DataModel(dates: dates, values: values);
  }
}

class YearRangeDataset {
  final DataModel yearDNI;
  final DataModel yearDIFF;
  final DataModel yearCloudAmount;

  YearRangeDataset({
    required this.yearDNI,
    required this.yearDIFF,
    required this.yearCloudAmount,
  });

  factory YearRangeDataset.fromJson(Map<String, dynamic> json) {
    return YearRangeDataset(
      yearDNI: DataModel.fromJson(json['properties']['parameter']['ALLSKY_SFC_SW_DNI']),
      yearDIFF: DataModel.fromJson(json['properties']['parameter']['ALLSKY_SFC_SW_DIFF']),
      yearCloudAmount: DataModel.fromJson(json['properties']['parameter']['CLOUD_AMT']) 
    );
  }

  List<double> getFiveYearGraph(String type) {
    switch(type) {
      case "cloud": {
        List<double> fiveYearMeans = [];
        for (var i = 0; i < yearDNI.values.length; i = i + 13) {
          fiveYearMeans.add(yearCloudAmount.values[i]);
        }
        return fiveYearMeans;
      }  
      case "solar": {
        List<double> fiveYearMeans = [];
        for (var i = 0; i < yearDNI.values.length; i = i + 13) {
          fiveYearMeans.add(yearDNI.values[i]+yearDIFF.values[i]);
        }
        return fiveYearMeans;
      }
      default: {
        return [];
      }
    } 
  }
}

class YearRangeData{
  final double jan;
  final double feb;
  final double mar;
  final double apr;
  final double may;
  final double jun;
  final double jul;
  final double aug;
  final double sep;
  final double oct;
  final double nov;
  final double dec;
  final double mean;

  YearRangeData({
    required this.jan,
    required this.feb,
    required this.mar,
    required this.apr,
    required this.may,
    required this.jun,
    required this.jul,
    required this.aug,
    required this.sep,
    required this.oct,
    required this.nov,
    required this.dec,
    required this.mean,
  });
  
  factory YearRangeData.fromJson(Map<String, dynamic> json, String year) {
    return YearRangeData(
      jan: json[year+"01"],
      feb: json[year+"02"],
      mar: json[year+"03"],
      apr: json[year+"04"],
      may: json[year+"05"],
      jun: json[year+"06"],
      jul: json[year+"07"],
      aug: json[year+"08"],
      sep: json[year+"09"],
      oct: json[year+"10"],
      nov: json[year+"11"],
      dec: json[year+"12"],
      mean: json[year+"13"]
    );
  }
}