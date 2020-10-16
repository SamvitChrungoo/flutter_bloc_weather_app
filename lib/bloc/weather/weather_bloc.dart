import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/repository/weather/models/weather_models.dart';
import 'package:flutter_weather_app/repository/weather/weather_api_client.dart';
import 'package:flutter_weather_app/repository/weather/weather_repository.dart';
import 'package:flutter_weather_app/utils/enums.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;
  WeatherBloc()
      : super(WeatherStateEmpty("Please search for a city in the search bar")) {
    weatherRepository = WeatherRepository(
        weatherApiClient: WeatherApiClient(httpClient: http.Client()));
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    switch (event.runtimeType) {
      case FetchWeatherEvent:
        yield* fetchWeather(event);
        break;
    }
  }

  Stream<WeatherState> fetchWeather(FetchWeatherEvent event) async* {
    try {
      yield WeatherStateLoading("");
      final Weather weather = await weatherRepository.getWeather(event.city);
      if (weatherRepository.status == Status.SUCCESS) {
        yield WeatherStateSuccess(weather);
      } else {
        yield WeatherStateError("Something went wrong, Please try again !");
      }
    } catch (error) {
      yield WeatherStateError("error: $error");
    }
  }
}
