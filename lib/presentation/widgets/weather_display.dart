import 'package:flutter/material.dart';

import '../../data/models/DailyWeather.dart';

class WeatherDisplay extends StatelessWidget {
  final DailyWeather weather;

  const WeatherDisplay(this.weather);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0), // Add padding below the entire widget
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
            height: 100,
          ),
          Text(
            "${weather.temperature}°C",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            weather.description.toUpperCase(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.water_drop, color: Colors.blue, size: 24),
                  Text("${weather.humidity}%"),
                  Text("Humidity"),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.air, color: Colors.grey, size: 24),
                  Text("${weather.windSpeed} m/s"),
                  Text("Wind"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
