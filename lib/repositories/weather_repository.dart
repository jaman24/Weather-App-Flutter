import 'package:weather_app/execptions/weather_execption.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/direct_geocoding.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/service/weather_api_service.dart';

class WeatherRepository {
  final WeatherApiService weatherApiService;
  WeatherRepository({
    required this.weatherApiService,
  });
  Future<Weather> fetchWeather(String city) async {
    try{
      final DirectGeocoding directGeocoding = await weatherApiService.getDirectGeocoding(city);

      final Weather tempWeather = await weatherApiService.getWeather(directGeocoding);

      final Weather weather = tempWeather.copyWith(name: directGeocoding.name, country: directGeocoding.country);

      return weather;
    }on WeatherExecption catch (e){
      throw CustomError(errMsg: e.message);
    }catch (e){
      throw CustomError(errMsg: e.toString());
    }
  }
  
}
