import 'package:bloc/bloc.dart';
import 'package:weather_app/cubits/weather/weather_state.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/utils/logger_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
    : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    LoggerService.i("Fetching weather for city: $city");
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));

      LoggerService.i("Weather loaded successfully for $city");
      LoggerService.d("State: $state");
    } on CustomError catch (e) {
      LoggerService.e("Failed to fetch weather for $city", e);
      emit(state.copyWith(status: WeatherStatus.error, error: e));
    }
  }
}
