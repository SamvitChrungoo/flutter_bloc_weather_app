import 'package:flutter_weather_app/common_components/generic_data_provider.dart';
import 'package:flutter_weather_app/utils/enums.dart';

import 'models/weather_models.dart';
import 'weather_api_client.dart';

abstract class AbstractWeatherRepository extends GenericDataProvider<Weather> {
  Future<Weather> getWeather(String city);
}

class WeatherRepository extends AbstractWeatherRepository {
  final WeatherApiClient weatherApiClient;
  WeatherRepository({this.weatherApiClient}) : assert(weatherApiClient != null);
  @override
  Future<Weather> getWeather(String city) async {
    try {
      status = Status.LOADING;
      final int locationId = await weatherApiClient.getLocationId(city);
      Weather weather = await weatherApiClient.fetchWeather(locationId);
      status = Status.SUCCESS;
      return weather;
    } catch (error) {
      errorMessage = error.toString();
      status = Status.ERROR;
      return null;
    }
  }
}
