import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'country_list_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCovidInfo();
  }

  Future<void> getCovidInfo() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await http.get(
      "https://api.covid19api.com/summary",
      headers: {"Accept": "application/json"},
    );
    prefs.setString(
        'covid', jsonDecode(response.statusCode.toString()).toString());
    //gotta pull the covid data here
//    var weatherData = await WeatherModel().getLocationWeather();
//
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CountryListScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitPulse(
              color: Colors.deepOrange[400],
              size: 100.0,
            ),
            FlatButton(
              child: Text('Loading...'),
            )
          ],
        ),
      ),
    );
  }
}
