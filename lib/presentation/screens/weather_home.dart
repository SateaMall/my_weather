import 'package:flutter/material.dart';
import 'package:my_weather/data/services/weather_service.dart';
import 'package:provider/provider.dart';
import '../../buisness_logic/weather_provider.dart';
import '../../data/services/city_service.dart';
import '../../data/services/weather_service.dart';
import '../widgets/weather_display.dart';
import '../widgets/forecast_widget.dart';

class WeatherHome extends StatefulWidget {

  @override
  _WeatherHomeState createState() => _WeatherHomeState();

}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final CityService _cityService = CityService();
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
        Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) async {
      if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
      }
      try {
      return await _cityService.fetchCitySuggestions(textEditingValue.text);
      } catch (e) {
      return const Iterable<String>.empty();
      }
      },
        onSelected: (String selection) {
          // Trigger weather fetching when a city is selected
          provider.fetchWeather(selection);
        },
        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: "Search for a city",
              border: OutlineInputBorder(),
            ),
          );
        },
      ),
        SizedBox(height: 20),
            provider.weather == null
                ? Center(child: Text("Enter a city to get weather"))
                : Column(
              children: [
                Center(child:
                Text(
                  provider.weather!.city,
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                ),),
                WeatherDisplay(provider.weather!.dailyWeather[0]), // Today's weather
                SizedBox(height: 20),
                ForecastWidget(provider.weather!.dailyWeather.sublist(1)), // Next 4 days
              ],
            ),
          ],
        ),
      ),
    );
  }
}
