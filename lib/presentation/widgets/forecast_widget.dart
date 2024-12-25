import 'package:flutter/material.dart';
import '../../data/models/DailyWeather.dart';

class ForecastWidget extends StatelessWidget {
  final List<DailyWeather> forecast;

  const ForecastWidget(this.forecast);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: forecast.map((weather) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                weather.dayOfWeek,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Image.network(
                    "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Min: ${weather.minTemperature}°C"),
                      Text("Max: ${weather.maxTemperature}°C"),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.water_drop, color: Colors.blue, size: 16),
                      Text("${weather.humidity}%"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.air, color: Colors.grey, size: 16),
                      Text("${weather.windSpeed} m/s"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
