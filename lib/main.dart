import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'buisness_logic/weather_provider.dart';

import 'presentation/screens/weather_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: WeatherHome(),
      ),
    );
  }
}