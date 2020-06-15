import 'dart:io';

import 'package:flutter/material.dart';
import 'package:searchtogo/widget/ResultCarousel.dart';

import '../MainBloc.dart';

class ResultPage extends StatelessWidget {

  final File imageFile;
  final ImageScanned state;
  final MainBloc mainBloc;

  ResultPage(this.imageFile, this.state , this.mainBloc);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                "Locations found!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 250,
                  width: 250,
                  child: FittedBox(
                    child: CircleAvatar(
                        radius: 30, backgroundImage: AssetImage(imageFile.path)),
                  )),
              SizedBox(
                height: 30,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
                size: 60.0,
              ),
              Text("Top Locations",style: TextStyle(fontSize: 30.0,fontFamily: 'Coolvetica'),),
              ResultCarousel(state),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                child: Text("BACK TO HOME"),
                onPressed: () => {
                  mainBloc.add(NewScanEvent())
                },
              )
            ],
          ),
          controller: scrollController,
        );
      },

    );
  }
}
