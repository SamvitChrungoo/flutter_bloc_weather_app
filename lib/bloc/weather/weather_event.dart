part of 'weather_bloc.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class FetchWeatherEvent extends WeatherEvent {
  String city;
  FetchWeatherEvent(this.city);
}
