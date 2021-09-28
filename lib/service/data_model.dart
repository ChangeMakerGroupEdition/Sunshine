import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<String> yearRange = ["2016", "2017", "2018", "2019", "2020"];

Future<YearRangeDataset> fetchFiveYearDataset() async{
  String cord = "latitude=3.1866&longitude=113.0403";
  String timePeriod = "&start=2016&end=2020";
  String parameters = "parameters=ALLSKY_SFC_LW_DWN,CLOUD_AMT,T2M,WS2M,QV2M";
  final res = await http.get(Uri.parse('https://power.larc.nasa.gov/api/temporal/monthly/point?' + parameters + '&community=SB&' + cord + timePeriod + '&format=JSON'));
  if(res.statusCode==200){
    return YearRangeDataset.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to load data.');
  }
}

Future<HourlyDataset> fetchHourlyDataset() async{
  String cord = "latitude=3.1866&longitude=113.0403";
  String timePeriod = "&start=2020&end=2020";
  String parameters = "parameters=ALLSKY_SFC_SW_DWN_HR,CLOUD_AMT_HR";
  final res = await http.get(Uri.parse('https://power.larc.nasa.gov/api/temporal/monthly/point?' + parameters + '&community=SB&' + cord + timePeriod + '&format=JSON'));
  if(res.statusCode==200){
    return HourlyDataset.fromJson(jsonDecode(res.body));
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
      if (value == -999) {
        values.add(0.0); 
      } else {
        values.add(value); 
      }
    });
    return DataModel(dates: dates, values: values);
  }

  List<double> getFiveYearGraph() {
    List<double> fiveYearMeans = [];
    for (var i = 0; i < values.length; i = i + 13) {
      fiveYearMeans.add(values[i]);
    }
    return fiveYearMeans;
  } 

  List<double> getLastYearGraph() {
    List<double> lastYear = [];
    for (var i = 1; i <= 12; i++) {
      lastYear.add(values[values.length-i-1]);
    }
    return lastYear;
  }
}

class YearRangeDataset {
  final DataModel dwn;
  final DataModel cloudAmount;
  final DataModel temperature;
  final DataModel windSpeed;
  final DataModel humidity;

  YearRangeDataset({
    required this.dwn,
    required this.cloudAmount,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
  });

  factory YearRangeDataset.fromJson(Map<String, dynamic> json) {
    return YearRangeDataset(
      dwn: DataModel.fromJson(json['properties']['parameter']['ALLSKY_SFC_LW_DWN']),
      cloudAmount: DataModel.fromJson(json['properties']['parameter']['CLOUD_AMT']),
      temperature: DataModel.fromJson(json['properties']['parameter']['T2M']),
      windSpeed: DataModel.fromJson(json['properties']['parameter']['WS2M']),
      humidity: DataModel.fromJson(json['properties']['parameter']["QV2M"])
    );
  }
}


class HourlyDataset {
  final List<double> dwn;
  final List<double> cloudAmount;

  HourlyDataset({
    required this.dwn,
    required this.cloudAmount,
  });

  factory HourlyDataset.fromJson(Map<String, dynamic> json) {
    List<double> dwn = List<double>.filled(15, 0);
    List<double> cloudAmount = List<double>.filled(15, 0);
    List<String> hourRange = ["21","22","23","00","01","02","03","04","05","06","07","08","09","10","11"];
    json['properties']['parameter'].forEach((key, value) {
      if(key.toString().startsWith("ALLSKY_SFC_SW_DWN")) {
        for (var element in hourRange) {
          if(key.toString().endsWith(element)) {
            dwn[hourRange.indexOf(element)] = value["202013"];
            break;
          }
        }
      }
      if(key.toString().startsWith("CLOUD_AMT")) {
        for (var element in hourRange) {
          if(key.toString().endsWith(element)) {
            cloudAmount[hourRange.indexOf(element)] = value["202013"];
            break;
          }
        }
      }
    });
    return HourlyDataset(
      dwn: dwn,
      cloudAmount: cloudAmount,
    );
  }
}