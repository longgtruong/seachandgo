import 'package:searchtogo/MainRepo.dart';

class TUIDestination {

  final String destination;
  final String city;
  final String country;
  final String infolink;
  final String vakantielink;
  final String img;
  final String details;
  final double lat;
  final double lon;
  final List<String> type;
  List<Weather> forecasts;

  String get getLabel => destination;
  String get getCity => city;
  String get getCountry => country;

  TUIDestination(this.destination,this.city,this.country,this.infolink,this.vakantielink, this.img,this.type,this.details, this.forecasts, this.lat, this.lon);


  addForecasts(List<Weather> forecasts) {
    this.forecasts = forecasts;
  }

}
