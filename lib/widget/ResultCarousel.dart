import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:searchtogo/MainBloc.dart';
import 'package:searchtogo/Result.dart';
import 'package:searchtogo/models/tuidestinations.dart';
import 'package:searchtogo/screens/destination_screen.dart';

class ResultCarousel extends StatelessWidget {


  final ImageScanned state;

  ResultCarousel(this.state);

  @override
  Widget build(BuildContext context) {

    List<Result> results = state.getResults;

    return Container(
      alignment: Alignment.center,
      height: 400.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index) {
            TUIDestination destination = results[index].getDestination;
            String label = results[index]
                .getLabel;
            return GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DestinationPage(destination))),
              child: Container(
                margin: EdgeInsets.all(20.0),
                width: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Hero(
                        tag: label,
                          child: Image.asset(
                        "assets/images/" + label + ".jpg",
                        fit: BoxFit.cover,
                        height: 340.0,
                      )),
                    ),
                    Positioned(
                      bottom: 5.0,
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Text(
                            destination.getLabel,
                            style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Coolvetica',
                                color: Colors.white),
                          )),
                          new LinearPercentIndicator(
                            width: 100.0,
                            lineHeight: 14.0,
                            percent: results[index].getConfidence,
                            center: Text((results[index].getConfidence * 100)
                                    .toString() +
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
          }),
    );
  }
}
