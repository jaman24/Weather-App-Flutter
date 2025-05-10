
class WeatherExecption implements Exception{
  String message;
  WeatherExecption([this.message = 'Something went wrong']){
    message = 'Weather Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}