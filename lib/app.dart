import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/weather/weather_bloc.dart';
import 'screens/weather/weather_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: MyWeatherPage(title: 'Weather'),
      ),
    );
  }
}
