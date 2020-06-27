import 'dart:io';

import 'package:flutter/material.dart';
import 'package:searchtogo/animation/FadeAnimation.dart';
import 'package:searchtogo/widget/Carousel.dart';

import '../MainBloc.dart';

class ResultPage extends StatelessWidget {
  final File imageFile;
  final ImageScanned state;
  final MainBloc mainBloc;

  ResultPage(this.imageFile, this.state, this.mainBloc);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  height: 500.0,
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/images/bg-1.png'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 250.0),
                        child: Center(
                          child: Text("LOCATION FOUND!",
                              style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: 'Coolvetica',
                                  color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 200.0),
                        child: Center(
                          child: Text(
                              "Here are some locations that matched our database",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Coolvetica',
                                  color: Colors.white)),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: (MediaQuery.of(context).size.width / 2) - 150.0,
                        child: Container(
                            width: 300,
                            height: 300,
                            child: FittedBox(
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(imageFile.path)),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
                size: 60.0,
              ),
              FadeIn(
                  1.8,
                  Text("Top Locations",
                      style:
                          TextStyle(fontSize: 30.0, fontFamily: 'Coolvetica'))),
              SizedBox(
                height: 30,
              ),
              FadeIn(
                2.0,
                CarouselWithIndicator(state,mainBloc),
              ),
              SizedBox(
                height: 30,
              ),
              OutlineButton(
                onPressed: () {
                  mainBloc.add(NewScanEvent());
                },
                borderSide: BorderSide(color: Color(0xff092460)),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 200.0,
                    child: Center(
                      child: Text('SCAN NEW PHOTO',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff092460),
                              fontWeight: FontWeight.bold)),
                    )),
              ),
              SizedBox(height: 10,),
              FlatButton(
                onPressed: () {
                  mainBloc.add(StartEvent());
                },
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Color(0xff09245f),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Center(
                    child: Text('BACK TO HOME',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
          controller: scrollController,
        );
      },
    );
  }
}
