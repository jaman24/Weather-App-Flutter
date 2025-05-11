import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/cubits/theme/theme_state.dart';

import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/cubits/weather/weather_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late final StreamSubscription weatherSubscription;

  final WeatherCubit weatherCubit;
  ThemeCubit({required this.weatherCubit}) : super(ThemeState.initial()) {
    weatherSubscription = weatherCubit.stream.listen((
      WeatherState weatherState,
    ) {
      print("WeatherState: $weatherState");

      if (weatherState.weather.temp > kWarmOrNot) {
        emit(state.copyWith(appTheme: AppTheme.light));
      } else {
        emit(state.copyWith(appTheme: AppTheme.dark));
      }
    });
  }

  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
