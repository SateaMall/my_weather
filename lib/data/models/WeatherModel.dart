import 'package:intl/intl.dart';
import 'package:my_weather/data/models/DailyWeather.dart';

class WeatherModel {
  final String city;
  final List<DailyWeather> dailyWeather;

  WeatherModel({required this.city, required this.dailyWeather});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> forecastList = json['list'];

    // Group forecasts by day
    final Map<String, List<dynamic>> groupedByDay = {};
    for (var item in forecastList) {
      String date = item['dt_txt'].split(' ')[0]; // Extract the date (YYYY-MM-DD)
      if (!groupedByDay.containsKey(date)) {
        groupedByDay[date] = [];
      }
      groupedByDay[date]!.add(item);
    }

    // Sort dates and select today + next 3 days
    List<String> sortedDates = groupedByDay.keys.toList()..sort();
    List<String> limitedDates = sortedDates.take(4).toList(); // Get only the first 4 dates (today + 3 days)

    // Create daily weather list for the limited dates
    List<DailyWeather> dailyWeather = limitedDates.map((date) {
      final List<dynamic> dayData = groupedByDay[date]!;

      // Calculate min and max temperatures for the day
      double minTemp = dayData.map((e) => e['main']['temp_min']).reduce((a, b) => a < b ? a : b);
      double maxTemp = dayData.map((e) => e['main']['temp_max']).reduce((a, b) => a > b ? a : b);

      // Use the first item's description and icon for the day's summary
      String description = dayData[0]['weather'][0]['description'];
      String icon = dayData[0]['weather'][0]['icon'];

      return DailyWeather(
        dayOfWeek: DateFormat.EEEE().format(DateTime.parse(date)),
        temperature: dayData[0]['main']['temp'], // Use the first item's temp as average temp
        minTemperature: minTemp,
        maxTemperature: maxTemp,
        humidity: dayData[0]['main']['humidity'],
        windSpeed: dayData[0]['wind']['speed'],
        description: description,
        icon: icon,
      );
    }).toList();

    return WeatherModel(
      city: json['city']['name'],
      dailyWeather: dailyWeather,
    );
  }
}
