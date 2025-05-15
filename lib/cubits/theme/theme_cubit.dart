import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/cubits/theme/theme_state.dart';
import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/cubits/weather/weather_state.dart';
import 'package:weather_app/utils/logger_service.dart'; // Import the logger

class ThemeCubit extends Cubit<ThemeState> {
  late final StreamSubscription weatherSubscription;

  final WeatherCubit weatherCubit;

  ThemeCubit({required this.weatherCubit}) : super(ThemeState.initial()) {
    weatherSubscription = weatherCubit.stream.listen((
      WeatherState weatherState,
    ) {
      LoggerService.d("WeatherState received: $weatherState");

      if (weatherState.weather.temp > kWarmOrNot) {
        emit(state.copyWith(appTheme: AppTheme.light));
        LoggerService.i("Theme changed to LIGHT");
      } else {
        emit(state.copyWith(appTheme: AppTheme.dark));
        LoggerService.i("Theme changed to DARK");
      }
    });
  }

  @override
  Future<void> close() {
    LoggerService.i("ThemeCubit closed. Cancelling weather subscription.");
    weatherSubscription.cancel();
    return super.close();
  }
}
