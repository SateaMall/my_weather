import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "14679af25891ca4a888c17257c663578";

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load weather data");
    }
  }

}
