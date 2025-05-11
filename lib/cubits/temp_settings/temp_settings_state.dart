import 'package:equatable/equatable.dart';

enum TempUnit { celcius, fahrenheit }

class TempSettingsState extends Equatable {
  final TempUnit tempUnit;
  const TempSettingsState({this.tempUnit = TempUnit.celcius});

  factory TempSettingsState.initial() {
    return TempSettingsState();
  }

  @override
  List<Object> get props => [tempUnit];

  @override
  bool get stringify => true;

  TempSettingsState copyWith({TempUnit? tempUnit}) {
    return TempSettingsState(tempUnit: tempUnit ?? this.tempUnit);
  }
}
