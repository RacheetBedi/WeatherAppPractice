import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                                child: const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(children: [
                                      Text(
                                        '300°F',
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

                //Weather Forecast Cards.
                const Placeholder(
                  fallbackHeight: 150,
                ),

                const SizedBox(height: 20),

                //Additional Information.
                const Placeholder(
                  fallbackHeight: 150,
                ),
              ],
            )));
  }
}
