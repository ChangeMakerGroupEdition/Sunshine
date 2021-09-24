import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataModel {
  //final List<double> hourlyDNR;
  //final List<double> hourlyDIFF;
  final double dailyDNR;
  final double dailyDIFF;
  final String title;
  //final Map<String, dynamic> data;

  DataModel({
    //required this.hourlyDNR,
    //required this.hourlyDIFF,
    required this.dailyDNR,
    required this.dailyDIFF,
    required this.title,
    //required this.data
  });

  factory DataModel.fromJson(Map<String, dynamic> json, String date) {
    return DataModel(
      //dnr: json['properties']['parameter']['ALLSKY_SFC_SW_DNI'].values.toList(),
      //diff: json['properties']['parameter']['ALLSKY_SFC_SW_DIFF'].values,
      //dailyDNR: json['properties']['parameter']['ALLSKY_SFC_SW_DNI'].values as double,
      title: json['header']['title'],
      dailyDNR: json['properties']['parameter']['ALLSKY_SFC_SW_DNI'][date],
      dailyDIFF: json['properties']['parameter']['ALLSKY_SFC_SW_DIFF'][date]
    );
  }
}

Future<DataModel> fetchData() async{
  String cord = "latitude=3.1866&longitude=113.0403";
  String date = "20210528";
  final res = await http.get(Uri.parse('https://power.larc.nasa.gov/api/temporal/daily/point?parameters=DNR,DIFF&community=SB&' + cord + '&start=' + date +  '&end=' + date + '&format=JSON'));
  if(res.statusCode==200){
    print(jsonDecode(res.body));
    return DataModel.fromJson(jsonDecode(res.body), date);
  } else {
    throw Exception('Failed to load data.');
  }
}