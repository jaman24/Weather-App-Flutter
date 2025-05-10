// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String description;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String name;
  final String country;
  final DateTime lastUpdated;
  const Weather({
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.name,
    required this.country,
    required this.lastUpdated,
  });

  @override
  List<Object> get props {
    return [
      description,
      icon,
      temp,
      tempMin,
      tempMax,
      name,
      country,
      lastUpdated,
    ];
  }

  @override
  bool get stringify => true;

  Weather copyWith({
    String? description,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    String? name,
    String? country,
    DateTime? lastUpdated,
  }) {
    return Weather(
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      name: name ?? this.name,
      country: country ?? this.country,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  factory Weather.fromJson(Map<String, dynamic> json){
    final weather = json['weather'][0];
    final main = json['main'];

    return Weather(description: weather['description'], icon: weather['icon'], temp: main['temp'], tempMin: main['tempMin'], tempMax: main['tempMax'], name: '', country: '', lastUpdated: DateTime.now());
  }

  factory Weather.initial() => Weather(description: '', icon: '', temp: 100.0, tempMin: 100.0, tempMax: 100.0, name: '', country: '', lastUpdated: DateTime(1970));
}
