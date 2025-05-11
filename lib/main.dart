import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/cubits/temp_settings/temp_settings_cubit.dart';
import 'package:weather_app/cubits/theme/theme_cubit.dart';
import 'package:weather_app/cubits/theme/theme_state.dart';
import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/service/weather_api_service.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Recommended for async in main
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create:
          (context) => WeatherRepository(
            weatherApiService: WeatherApiService(httpClient: http.Client()),
          ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create:
                (context) => WeatherCubit(
                  weatherRepository: context.read<WeatherRepository>(),
                ),
          ),
          BlocProvider<TempSettingsCubit>(
            create: (context) => TempSettingsCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create:
                (context) =>
                    ThemeCubit(weatherCubit: context.read<WeatherCubit>()),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Weather App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light().copyWith(
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 8,
                ),
              ),
              darkTheme: ThemeData.dark().copyWith(
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 57, 57, 57),
                  foregroundColor: Colors.white,
                  elevation: 8,
                ),
              ),
              themeMode:
                  context.watch<ThemeCubit>().state.appTheme == AppTheme.light
                      ? ThemeMode.light
                      : ThemeMode.dark,

              home: HomePage(),
            );
          },
        ),
      ),
    );
  }
}
