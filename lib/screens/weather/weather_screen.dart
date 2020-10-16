import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/weather/weather_bloc.dart';
import 'package:flutter_weather_app/screens/weather/weather_conditions.dart';

class MyWeatherPage extends StatefulWidget {
  MyWeatherPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyWeatherPageState createState() => _MyWeatherPageState();
}

class _MyWeatherPageState extends State<MyWeatherPage> {
  TextEditingController controller = TextEditingController();
  WeatherBloc weatherBloc = WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    hintText: "Enter the city name",
                  ),
                )),
            RaisedButton(
                child: Text(
                  "Search",
                  style: TextStyle(
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                color: Colors.orange.withOpacity(0.85),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  weatherBloc.add(FetchWeatherEvent(controller.text.trim()));
                }),
            SizedBox(height: 100),
            BlocBuilder<WeatherBloc, WeatherState>(
              cubit: weatherBloc,
              builder: (context, state) {
                print("state :::::: $state");
                if (state is WeatherStateLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is WeatherStateSuccess) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: WeatherConditions(
                                condition: state.data.condition),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.data.location,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                'Updated: ${TimeOfDay.fromDateTime(state.data.lastUpdated).format(context)}',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                '${state.data.temp.round()}°',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'max: ${state.data.maxTemp.round()}°',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'min: ${state.data.minTemp.round()}°',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          state.data.formattedCondition,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state is WeatherStateEmpty) {
                  return Text(
                    state.emptyMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                  );
                }
                if (state is WeatherStateError) {
                  return Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ));
  }
}
