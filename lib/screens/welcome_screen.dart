import 'package:flutter/material.dart';
import 'package:searchtogo/MainBloc.dart';

class WelcomePage extends StatelessWidget {
  final MainBloc mainBloc;

  WelcomePage(this.mainBloc);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            height: 400.0,
            child: Stack(
              children: <Widget>[
                Image.asset('assets/images/bg-1.png'),
                Padding(
                  padding: const EdgeInsets.only(bottom:150.0),
                  child: Center(
                    child: Text("SEARCHTOGO",
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Coolvetica',
                            color: Colors.white)),
                  ),
                ),
                Positioned(
                    bottom: 10.0,
                    left: 60.0,
                    child: Image.asset(
                      'assets/images/logo.png',
                      scale: 0.8,
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 80.0,
        ),
        Center(
          child: OutlineButton(
            onPressed: () {
              mainBloc.add(UploadEvent());
            },
            borderSide: BorderSide(color: Color(0xff092460)),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 200.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Text('GET STARTED',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff092460),
                          fontWeight: FontWeight.bold)),
                  Icon(
                    Icons.arrow_forward,
                    color: Color(0xff092460),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        Center(
          child: FlatButton(
            onPressed: () {
              mainBloc.add(FavoriteListEvent());
            },
            color: Color(0xff092460),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 200.0,
              child: Center(
                child: Text('FAVORITES',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        Center(
          child: FlatButton(
            onPressed: () {
              mainBloc.add(InfoEvent());
            },
            color: Color(0xff092460),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 200.0,
              child: Center(
                child: Text('INFO',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
