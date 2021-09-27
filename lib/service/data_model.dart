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

Future<YearRangeDataset> fetchFiveYearDataset() async{
  String cord = "latitude=3.1866&longitude=113.0403";
  String timePeriod = "&start=2016&end=2020";
  String parameters = "parameters=ALLSKY_SFC_LW_DWN,CLOUD_AMT,T2M,WS2M";
  final res = await http.get(Uri.parse('https://power.larc.nasa.gov/api/temporal/monthly/point?' + parameters + '&community=SB&' + cord + timePeriod + '&format=JSON'));
  print(res.body);
  if(res.statusCode==200){
    print(jsonDecode(res.body));
    return YearRangeDataset.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to load data.');
  }
}

// Future<HourlyDataset> fetchHourlyDataset() async{
//   String cord = "latitude=3.1866&longitude=113.0403";
//   String timePeriod = "&start=2016&end=2020";
//   String parameters = "parameters=ALLSKY_SFC_LW_DWN,CLOUD_AMT,T2M,WS2M";
//   final res = await http.get(Uri.parse('https://power.larc.nasa.gov/api/temporal/monthly/point?' + parameters + '&community=SB&' + cord + timePeriod + '&format=JSON'));
//   print(res.body);
//   if(res.statusCode==200){
//     print(jsonDecode(res.body));
//     return YearRangeDataset.fromJson(jsonDecode(res.body));
//   } else {
//     throw Exception('Failed to load data.');
//   }
// }

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
      if (value == -999) {
        values.add(0.0); 
      } else {
        values.add(value); 
      }
    });
    return DataModel(dates: dates, values: values);
  }
}

class YearRangeDataset {
  final DataModel dwn;
  final DataModel cloudAmount;
  final DataModel temperature;
  final DataModel windSpeed;

  YearRangeDataset({
    required this.dwn,
    required this.cloudAmount,
    required this.temperature,
    required this.windSpeed,
  });

  factory YearRangeDataset.fromJson(Map<String, dynamic> json) {
    return YearRangeDataset(
      dwn: DataModel.fromJson(json['properties']['parameter']['ALLSKY_SFC_LW_DWN']),
      cloudAmount: DataModel.fromJson(json['properties']['parameter']['CLOUD_AMT']),
      temperature: DataModel.fromJson(json['properties']['parameter']['T2M']),
      windSpeed: DataModel.fromJson(json['properties']['parameter']['WS2M']),
    );
  }

  List<double> getFiveYearGraph(String type) {
    switch(type) {
      case "cloud": {
        List<double> fiveYearMeans = [];
        for (var i = 0; i < cloudAmount.values.length; i = i + 13) {
          fiveYearMeans.add(cloudAmount.values[i]);
        }
        return fiveYearMeans;
      } 
      case "solar": {
        List<double> fiveYearMeans = [];
        for (var i = 0; i < dwn.values.length; i = i + 13) {
          fiveYearMeans.add(dwn.values[i]);
        }
        return fiveYearMeans;
      } 
      case "temp": {
        List<double> fiveYearMeans = [];
        for (var i = 0; i < temperature.values.length; i = i + 13) {
          fiveYearMeans.add(temperature.values[i]);
        }
        return fiveYearMeans;
      } 
      case "wind": {
        List<double> fiveYearMeans = [];
        for (var i = 0; i < windSpeed.values.length; i = i + 13) {
          fiveYearMeans.add(windSpeed.values[i]);
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
          lastYear.add(cloudAmount.values[cloudAmount.values.length-i-1]);
        }
        return lastYear;
      }
      case "solar": {
        List<double> lastYear = [];
        for (var i = 1; i <= 12; i++) {
          lastYear.add(dwn.values[dwn.values.length-i-1]);
        }
        return lastYear;
      }
      case "temp": {
        List<double> lastYear = [];
        for (var i = 1; i <= 12; i++) {
          lastYear.add(temperature.values[temperature.values.length-i-1]);
        }
        return lastYear;
      }
      case "wind": {
        List<double> lastYear = [];
        for (var i = 1; i <= 12; i++) {
          lastYear.add(windSpeed.values[windSpeed.values.length-i-1]);
        }
        return lastYear;
      }
      default: {
        return [];
      }
    } 
  }
}

// class HourlyData {
  
// }

// class HourlyDataset {
//   final DataModel dwn;
//   final DataModel cloudAmount;
//   final DataModel temperature;
//   final DataModel windSpeed;

//   HourlyDataset({
//     required this.dwn,
//     required this.cloudAmount,
//     required this.temperature,
//     required this.windSpeed,
//   });

//   factory HourlyDataset.fromJson(Map<String, dynamic> json) {
//     List<double> dwn = [];
//     json['properties']['parameter'].forEach((key, value) {
//       if(key.toString().startsWith("ALLSKY_SFC_LW_DWN"))
//     })
//     return HourlyDataset(
//       dwn: DataModel.fromJson(json['properties']['parameter']['ALLSKY_SFC_LW_DWN']),
//       cloudAmount: DataModel.fromJson(json['properties']['parameter']['CLOUD_AMT']),
//       temperature: DataModel.fromJson(json['properties']['parameter']['T2M']),
//       windSpeed: DataModel.fromJson(json['properties']['parameter']['WS2M']),
//     );
//   }
// }