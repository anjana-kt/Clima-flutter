import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({ this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String cityName ;
  int condition;
  String message;
  WeatherModel weather=WeatherModel();
  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }
  void updateUI(dynamic weatherData){
    print(weatherData['name']);
    setState(() {
     try {
       temperature = weatherData['main']['temp'].toInt();
       cityName = weatherData['name'];
       condition = weatherData['weather'][0]['id'];
       message = weather.getMessage(temperature) + ' time in ';
       print("Anjana");
     }
     catch(e){
       print(e);
       temperature = 0;
       cityName = '';
       condition = 805;
       message = 'Error unable to get location!';
     }
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
                    onPressed: ()async {
                      var weatherData =await weather.getLocationWeather();
                      print(weatherData);
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var inputName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      })
                      );
                    if (inputName!=null){
                      var weatherData=await weather.getCityWeather(inputName);
                      updateUI(weatherData);
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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${weather.getWeatherIcon(condition)}',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message $cityName!",
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
/*double temperature = decodedData['main']['temp'];
    String cityName = decodedData['name'];
    int condition = decodedData['weather'][0]['description'];*/