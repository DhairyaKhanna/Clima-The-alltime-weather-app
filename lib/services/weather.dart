import 'location.dart';
import 'networking.dart';

const apikey = 'a41a635e6f799ca258be3e1fa03272b3';

class WeatherModel {
  double latitude;
  double longitude;

  Future<dynamic> getcityweather(String cityname) async {
    var url =
        'https://samples.openweathermap.org/data/2.5/weather?q=${cityname}&appid=$apikey';
    Network network = Network(url);
    var cityweatherdata = await network.response();
    print(cityweatherdata);
    return cityweatherdata;
  }

  Future<dynamic> getlocationweather() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    Network network = Network(
        'https://samples.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey');

    var weatherdata = await network.response();
    print(weatherdata);

    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
