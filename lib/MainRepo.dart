import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:searchtogo/Result.dart';
import 'package:searchtogo/ScanModel.dart';
import 'package:tflite/tflite.dart';
import 'package:http/http.dart' as http;

import 'models/tuidestinations.dart';

class HomeRepo {

  var destinations;

  loadDestinations() async {
    await rootBundle.loadString('assets/tflite/destinations.json').then((value) => {
      destinations = jsonDecode(value)["destinations"]
    });
  }

  getDestination(String label) {
    TUIDestination destination;
    for (int i=0;i<destinations.length;i++) {
      if (destinations[i]["label"].toString() == label) {
        String city = destinations[i]["city"];
        String country = destinations[i]["country"];
        double lon = destinations[i]["longitude"];
        double lat = destinations[i]["latitude"];
        destination = new TUIDestination(destinations[i]["label"], city, country, "", "", "", [], destinations[i]["details"], null, lat, lon);
      }
    }
    return destination;
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/tflite/model_unquant.tflite",
        labels: "assets/tflite/labels.txt",
        numThreads: 1
    );
  }

  Future<Scan> getLocation(File img) async {
    var output = await Tflite.runModelOnImage(
      path: img.path,
      numResults: 10,
      imageMean: 0.0,
      imageStd: 255.0,
      threshold: 0.0,
    );

    print(output);

    List<Result> results = [];

    for (int i=0;i<output.length;i++) {
      String label = output[i]["label"].toString().substring(2, output[i]["label"].toString().length);
      results.add(new Result(output[i]["label"],output[i]["confidence"],"", getDestination(label)));
    }

    return Scan(img,results);
  }


  getWeather(String lat, String lon) async {
    List<Weather> forecasts = [];
    http.Response response = await http.get('http://api.openweathermap.org/data/2.5/forecast?lat='+lat+'&lon='+lon+'&appid=3dcd2234201decc0853fe692ad5aab3b&units=metric');
    var results = jsonDecode(response.body);
    var forecastsResult = results["list"];
    var now = Jiffy([DateTime.now().year, DateTime.now().month, DateTime.now().day]); // get current date
    for (int i=0;i<forecastsResult.length;i+=8) {
      forecasts.add(new Weather(now.format("MMM dd"),forecastsResult[i]["main"]["temp"]));
      now.add(days: 1);
    }
    return forecasts;
  }

  getWeatherByCountry(String country) async {
    List<Weather> forecasts = [];
    http.Response response = await http.get('http://api.openweathermap.org/data/2.5/forecast?q='+country+'&appid=3dcd2234201decc0853fe692ad5aab3b&units=metric');
    var results = jsonDecode(response.body);
    var forecastsResult = results["list"];
    var now = Jiffy([DateTime.now().year, DateTime.now().month, DateTime.now().day]); // get current date
    for (int i=0;i<forecastsResult.length;i+=8) {
      forecasts.add(new Weather(now.format("MMM dd"),forecastsResult[i]["main"]["temp"]));
      now.add(days: 1);
    }
    return forecasts;
  }
}

class Weather {

  String date;
  double degree;

  Weather(this.date,this.degree);

}



