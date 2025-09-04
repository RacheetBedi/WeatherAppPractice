import 'dart:convert';
import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterpracticeprojects2/secrets.dart';

import 'additional_info_item.dart';
import 'hourly_forecast_item.dart';

import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    final data;
    try {
      String cityName = 'London';
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName,uk&APPID=$openWeatherAPIKey'),
      );

      print(result.body);

      data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      setState(() {
        temp = data['list'][0]['main']['temp'];
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                print('Refresh');
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: temp == 0
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //main card.
                    Container(
                        width: double.infinity,
                        child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(children: [
                                          Text(
                                            '$temp',
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Icon(
                                            Icons.cloud,
                                            size: 64,
                                          ),
                                          Text('Rain',
                                              style: TextStyle(
                                                fontSize: 20,
                                              )),
                                        ])))))),

                    const SizedBox(height: 20),

                    const Text('Weather Forecast',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),

                    const SizedBox(
                      height: 8,
                    ),

                    const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            HourlyForecastItem(
                              time: '00:00',
                              icon: Icons.cloud,
                              temperature: '301.22',
                            ),
                            HourlyForecastItem(
                              time: '03:00',
                              icon: Icons.sunny,
                              temperature: '300.52',
                            ),
                            HourlyForecastItem(
                              time: '06:00',
                              icon: Icons.cloud,
                              temperature: '302.22',
                            ),
                            HourlyForecastItem(
                              time: '09:00',
                              icon: Icons.sunny,
                              temperature: '300.12',
                            ),
                            HourlyForecastItem(
                              time: '12:00',
                              icon: Icons.cloud,
                              temperature: '304.12',
                            ),
                          ],
                        )),

                    const SizedBox(height: 20),

                    const Text('Additional Forecast',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),

                    const SizedBox(
                      height: 8,
                    ),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalForecastItem(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: '91',
                        ),
                        AdditionalForecastItem(
                          icon: Icons.air,
                          label: 'Wind Speed',
                          value: '7.5',
                        ),
                        AdditionalForecastItem(
                          icon: Icons.beach_access,
                          label: 'Pressure',
                          value: '1000',
                        ),
                      ],
                    )
                  ],
                )));
  }
}
