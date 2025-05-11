import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/service/weather_api_service.dart';
import 'package:weather_app/widgets/error_dialog.dart';

import '../cubits/weather/weather_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? _city;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
              print("City: $_city");
              if (_city != null) {
                context.read<WeatherCubit>().fetchWeather(_city!);
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: _showWeather(),
    );
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (BuildContext context, WeatherState state) {
        if (state.status == WeatherStatus.initial) {
          return const Center(
            child: Text('Select a city', style: TextStyle(fontSize: 20.0)),
          );
        }

        if (state.status == WeatherStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.status == WeatherStatus.error && state.weather.name == '') {
          return const Center(
            child: Text('Select a city', style: TextStyle(fontSize: 20.0)),
          );
        }

        return Center(
          child: Text(
            state.weather.name,
            style: const TextStyle(fontSize: 18.0),
          ),
        );
      },
    );
  }
}
