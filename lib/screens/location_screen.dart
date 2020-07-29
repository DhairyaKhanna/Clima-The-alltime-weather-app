import '../screens/city_screen.dart';
import '../services/weather.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.weatherdata);

  final weatherdata;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int condition;
  String cityname;
  double temperature;
  int temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.weatherdata);
    updateUI(widget.weatherdata);
  }

  void updateUI(dynamic weatherdata) async {
    setState(() {
      if (weatherdata == null) {
        cityname = 'Server side error or check your internet connection!!';
        temperature = 0;
        return;
      }
      condition = jsonDecode(weatherdata)['weather'][0]['id'];
      cityname = jsonDecode(weatherdata)['name'];
      temperature = jsonDecode(weatherdata)['main']['temp'];
      temperature = temperature - 273;
      temp = temperature.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var newweatherdata =
                          await weatherModel.getlocationweather();
                      updateUI(newweatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedname != null) {
                        var weatherdata =
                            await weatherModel.getcityweather(typedname);
                        updateUI(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${weatherModel.getWeatherIcon(condition)}',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '${weatherModel.getMessage(temp)} in $cityname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
