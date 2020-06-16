import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:searchtogo/models/tuidestinations.dart';
import 'package:searchtogo/screens/destination_screen.dart';

import '../Result.dart';

class CarouselItem extends StatelessWidget {

  final Result result;

  CarouselItem(this.result);

  @override
  Widget build(BuildContext context) {
    TUIDestination destination = result.destination;
    String label = result.destination.getLabel;
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => DestinationPage(destination))),
      child: Container(
        width: 300.0,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Hero(
                  tag: label,
                  child: Image.asset(
                    'assets/images/'+label+'.jpg',
                    fit: BoxFit.cover,
                    height: 425.0,
                    width: 300.0,
                  )),
            ),
            Positioned(
              bottom: 5.0,
              child: Column(
                children: <Widget>[
                  Center(
                      child: Text(
                        label,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Coolvetica',
                            color: Colors.white),
                      )),
                  new LinearPercentIndicator(
                    width: 100.0,
                    lineHeight: 14.0,
                    percent: result.getConfidence,
                    center: Text((result.getConfidence * 100).round().toString() +
                        "%"),
                    backgroundColor: Colors.white,
                    progressColor: Colors.blue,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
