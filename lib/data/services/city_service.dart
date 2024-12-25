import 'dart:convert';
import 'package:http/http.dart' as http;

class CityService {
  final String apiKey = '14679af25891ca4a888c17257c663578';

  /// Fetches city suggestions from OpenWeather's geocoding API
  Future<List<String>> fetchCitySuggestions(String query) async {
    final url =
        'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=10&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Filter and deduplicate results
        final Set<String> citySet = {}; // To ensure uniqueness
        final List<String> suggestions = [];

        for (var city in data) {
          if (city['name'] != null &&
              city['lat'] != null &&
              city['lon'] != null) {
            String cityName = city['name'];
            if (!citySet.contains(cityName)) {
              citySet.add(cityName); // Add to the set to avoid duplicates
              suggestions.add(cityName); // Add to the final list
            }
          }
        }

        return suggestions;
      } else {
        throw Exception('Failed to fetch city suggestions');
      }
    } catch (e) {
      throw Exception('Error fetching city suggestions: $e');
    }
  }
}
