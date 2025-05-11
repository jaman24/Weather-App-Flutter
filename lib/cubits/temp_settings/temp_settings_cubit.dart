import 'package:bloc/bloc.dart';
import 'package:weather_app/cubits/temp_settings/temp_settings_state.dart';

class TempSettingsCubit extends Cubit<TempSettingsState> {
  TempSettingsCubit() : super(TempSettingsState.initial());

  void toggleTempUnit() {
    emit(
      state.copyWith(
        tempUnit:
            state.tempUnit == TempUnit.celcius
                ? TempUnit.fahrenheit
                : TempUnit.celcius,
      ),
    );
    print('Unit: $state');
  }
}
