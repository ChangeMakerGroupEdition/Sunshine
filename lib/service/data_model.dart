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
    json.forEach((key, value) {
      dates.add(key); 
      if (value == -999.0) {
        values.add(0.0); 
      } else {
        values.add(value); 
      }
    });
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
  
  List<double> getLastYearGraph(String type) {
    switch(type) {
      case "cloud": {
        List<double> lastYear = [];
        for (var i = 1; i <= 12; i++) {
          lastYear.add(yearCloudAmount.values[yearCloudAmount.values.length-i-1]);
        }
        return lastYear;
      }  
      case "solar": {
        List<double> lastYear = [];
        for (var i = 1; i <= 12; i++) {
          lastYear.add(yearDNI.values[yearDNI.values.length-i-1]+yearDIFF.values[yearDIFF.values.length-i-1]);
        }
        return lastYear;
      }
      default: {
        return [];
      }
    } 
  }
}
