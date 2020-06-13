import 'package:searchtogo/models/tuidestinations.dart';

class Result {

  final label;
  final confidence;
  final booklink;
  final TUIDestination destination;


  String get getLabel => label;
  double get getConfidence => confidence;
  String get getLink => booklink;
  TUIDestination get getDestination => destination;

  Result(this.label,this.confidence,this.booklink, this.destination);

}