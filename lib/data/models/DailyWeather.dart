import 'package:intl/intl.dart';

class DailyWeather {
  final String dayOfWeek;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final String icon;

  DailyWeather({
    required this.dayOfWeek,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.parse(json['dt_txt']);
    String dayOfWeek = DateFormat.EEEE().format(date);

    return DailyWeather(
      dayOfWeek: dayOfWeek,
      temperature: json['main']['temp'].toDouble(),
      minTemperature: json['main']['temp_min'].toDouble(),
      maxTemperature: json['main']['temp_max'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
