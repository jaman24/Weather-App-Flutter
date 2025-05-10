// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;
  
  const DirectGeocoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  @override
  List<Object> get props => [name, lat, lon, country];

  @override
  bool get stringify => true;

  factory DirectGeocoding.fromJson(List<dynamic> json){
    final Map<String, dynamic> data = json[0];

    return DirectGeocoding(name: data['name'], lat: data['lat'], lon: data['lon'], country: data['country']);
  }
}
