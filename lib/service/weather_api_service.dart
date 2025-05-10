import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/execptions/weather_execption.dart';
import 'package:weather_app/models/direct_geocoding.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/service/http_error_handler.dart';

class WeatherApiService {
  final http.Client httpClient;
  WeatherApiService({
    required this.httpClient,
  });
  
  Future<DirectGeocoding> getDirectGeocoding(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      }
    );

    try{
      final http.Response response = await httpClient.get(uri);

      if(response.statusCode != 200){
        throw httpErrorHandler(response);
      }

      final responseBody = json.decode(response.body);

      if(responseBody.isEmpty){
        throw WeatherExecption('Cannot get the location of $city');
      }

      final directGeoconding = DirectGeocoding.fromJson(responseBody);
      print('directGeocoding: $directGeoconding');

      return directGeoconding;
    }catch(e){
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeoconding) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${directGeoconding.lat}',
        'lon': '${directGeoconding.lon}',
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      }
    );

    try{
      final http.Response response = await httpClient.get(uri);

      if(response.statusCode != 200){
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);

      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    }catch(e){
      rethrow;
    }
  }
}
