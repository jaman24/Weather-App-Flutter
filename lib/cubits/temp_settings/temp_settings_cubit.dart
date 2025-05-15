import 'package:bloc/bloc.dart';
import 'package:weather_app/cubits/temp_settings/temp_settings_state.dart';
import 'package:weather_app/utils/logger_service.dart';

class TempSettingsCubit extends Cubit<TempSettingsState> {
  TempSettingsCubit() : super(TempSettingsState.initial());

  void toggleTempUnit() {
    final newUnit =
        state.tempUnit == TempUnit.celcius
            ? TempUnit.fahrenheit
            : TempUnit.celcius;

    emit(state.copyWith(tempUnit: newUnit));

    LoggerService.i(
      "Temperature unit toggled to ${newUnit.name.toUpperCase()}",
    );
    LoggerService.d("New TempSettingsState: $state");
  }
}
