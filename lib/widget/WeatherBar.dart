import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../MainRepo.dart';

class WeatherBar extends StatelessWidget {
  final List<Weather> weather;

  WeatherBar(this.weather);

  Widget getWeatherIcon(int degree) {
    if (degree > 18) {
      return Icon(Icons.wb_sunny, color: Colors.white);
    } else if (degree < 18 && degree > 15) {
      return Icon(Icons.cloud, color: Colors.white);
    } else {
      return FaIcon(FontAwesomeIcons.cloudSunRain, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.lightBlueAccent, Colors.deepPurpleAccent])

        ),
        alignment: Alignment.center,
        height: 130.0,
        width: MediaQuery.of(context).size.width-40,
        padding: EdgeInsets.only(top:30,bottom: 30,left: 5.0,right: 5.0),
        child:
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weather.length,
                itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 1
                    )
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0,right: 15.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        weather[index].degree.round().toString()+"°C",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      getWeatherIcon(weather[index].degree.round()),
                      Text(
                        weather[index].date,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
