import 'dart:async';
import 'dart:convert';

import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class CountrySpecificScreen extends StatefulWidget {
  String countryName;
  String countryShort;
  String jsonCovidData;

  @override
  _CountrySpecificScreenState createState() => _CountrySpecificScreenState();
  CountrySpecificScreen({Key key, this.countryShort, this.countryName})
      : super(key: key);
}

class _CountrySpecificScreenState extends State<CountrySpecificScreen> {
  String _flagUrl = '';
  CountryDetails _countryDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryFlag();
    initialiseJsonData();
  }

  Future<void> initialiseJsonData() async {
    var response = await http.get(
      "https://api.covid19api.com/total/dayone/country/${widget.countryShort}",
      headers: {"Content-Type": "application/json"},
    );
    setState(() {
      _countryDetails = new CountryDetails();
      _countryDetails = new CountryDetails();
      _countryDetails.confirmed = json.decode(response.body).last['Confirmed'];
      _countryDetails.deaths = json.decode(response.body).last['Deaths'];
      _countryDetails.recovered = json.decode(response.body).last['Recovered'];
      _countryDetails.active = json.decode(response.body).last['Active'];
      _countryDetails.lastUpdated =
          json.decode(response.body).last['Date'].toString().substring(0, 10);
    });
  }

  Future<void> getCountryFlag() async {
    var response = await http.get(
      "https://restcountries.eu/rest/v2/alpha/${widget.countryShort}",
      headers: {"Content-Type": "application/json"},
    );
    setState(() {
      this._flagUrl = json.decode(response.body)['flag'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        child: ClayContainer(
          surfaceColor: Colors.white,
          depth: 150,
          emboss: true,
          color: Colors.white,
          customBorderRadius: BorderRadius.only(
            topRight: Radius.circular(60),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40),
                child: Container(
                  color: Colors.transparent,
                  child: Text(
                    widget.countryName,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Comfortaa',
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: ClayContainer(
                  width: double.infinity,
                  color: Colors.blueGrey[100],
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 40),
                    child: SvgPicture.network(
                      _flagUrl,
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                      placeholderBuilder: (BuildContext context) => Container(
                        child: SpinKitPulse(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _countryDetails != null
                  ? ClayContainer(
                      color: Colors.white10,
                      emboss: true,
                      borderRadius: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClayText(
                              "Confirmed Cases: ${_countryDetails.getConfimed().toString()}",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                              ),
                              color: Colors.black,
                              depth: 1000,
                              emboss: true,
                              spread: 100,
                            ),
                            ClayText(
                              "Recovered Cases: ${_countryDetails.getRecovered().toString()}",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                              ),
                              color: Colors.black,
                              depth: 1000,
                              emboss: true,
                              spread: 100,
                            ),
                            ClayText(
                              "Active Cases: ${_countryDetails.getActive().toString()}",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                              ),
                              color: Colors.black,
                              depth: 1000,
                              emboss: true,
                              spread: 100,
                            ),
                            ClayText(
                              "Deaths: ${_countryDetails.getDeaths().toString()}",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                              ),
                              color: Colors.black,
                              depth: 1000,
                              emboss: true,
                              spread: 100,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                "Last Updated: ${_countryDetails.getLastUpdated().toString()}",
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SpinKitPulse(
                      color: Colors.blueGrey,
                    ),

//              Flexible(
//                child: Padding(
//                  padding: const EdgeInsets.all(2),
//                  child: Container(
//                    color: Colors.transparent,
//                    child: Text(
//                      "Last Updated: ${_countryDetails.getLastUpdated()}",
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 20,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryDetails {
  int confirmed;
  int deaths;
  int recovered;
  int active;
  String lastUpdated;

  int getConfimed() {
    return confirmed;
  }

  int getDeaths() {
    return deaths;
  }

  int getRecovered() {
    return recovered;
  }

  int getActive() {
    return active;
  }

  String getLastUpdated() {
    return lastUpdated;
  }
}
