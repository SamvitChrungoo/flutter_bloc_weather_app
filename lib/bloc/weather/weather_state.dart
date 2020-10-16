part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  final Weather data;
  WeatherState(this.data);
  @override
  List<Object> get props => [data];
}

class WeatherStateLoading extends WeatherState {
  final String loading;
  WeatherStateLoading(this.loading) : super(null);
}

class WeatherStateSuccess extends WeatherState {
  final Weather data;
  WeatherStateSuccess(this.data) : super(null);
}

class WeatherStateError extends WeatherState {
  final String errorMessage;
  WeatherStateError(this.errorMessage) : super(null);
}

class WeatherStateEmpty extends WeatherState {
  final String emptyMessage;
  WeatherStateEmpty(this.emptyMessage) : super(null);
}
