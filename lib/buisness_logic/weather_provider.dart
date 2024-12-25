import 'package:flutter/material.dart';
import '../data/models/WeatherModel.dart';
import '../data/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _service = WeatherService();
  WeatherModel? _weather;

  WeatherModel? get weather => _weather;

  Future<void> fetchWeather(String city) async {
    final response = await _service.fetchWeather(city);
    _weather = WeatherModel.fromJson(response);
    notifyListeners();
  }
}
