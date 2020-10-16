import 'package:flutter_weather_app/utils/enums.dart';

abstract class GenericDataProvider<T> {
  Status status;
  T data;
  String errorMessage;
}
