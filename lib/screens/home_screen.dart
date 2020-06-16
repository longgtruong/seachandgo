import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchtogo/MainBloc.dart';
import 'package:searchtogo/animation/FadeAnimation.dart';
import 'package:searchtogo/screens/result_screen.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  File imageFile;
  bool loaded;
  String buttonBackground = "";
  bool scanBtnDisabled = true;

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);

    Future<void> _showDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    GestureDetector(
                      child: Container(
                        child: Center(
                            child: Icon(
                          Icons.camera_enhance,
                          color: Colors.black,
                        )),
                        color: Colors.grey,
                        width: 100.0,
                        height: 100.0,
                      ),
                      onTap: () async {
                        var picture = await ImagePicker.pickImage(
                            source: ImageSource.camera);
                        this.setState(() {
                          imageFile = picture;
                        });
                        Navigator.of(context).pop();
                        if (imageFile != null) {
                          mainBloc.add(UploadEvent(imageFile));
                        }
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      child: Container(
                        child: Center(
                            child: Icon(
                          Icons.photo_library,
                          color: Colors.black,
                        )),
                        color: Colors.grey,
                        width: 100.0,
                        height: 100.0,
                      ),
                      onTap: () async {
                        var picture = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        this.setState(() {
                          imageFile = picture;
                        });
                        Navigator.of(context).pop();
                        if (imageFile != null) {
                          mainBloc.add(UploadEvent(imageFile));
                        }
                      },
                    )
                  ])),
            );
          });
    }

    return Container(
      child: BlocBuilder<MainBloc, HomeState>(
        builder: (context, state) {
          if (state is NotUploaded)
            return FadeIn(
              0.5,
              Center(
                child: Container(
                    width: 300.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 150.0),
                        Center(
                            child: Text(
                          "UPLOAD YOUR PHOTO",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xff09245f),
                              fontFamily: 'Coolvetica'),
                        )),
                        SizedBox(height: 30.0),
                        GestureDetector(
                          onTap: () => {_showDialog(context)},
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff09245f), width: 1)),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 100.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        FlatButton(
                          onPressed: () {

                          },
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                Text('SCAN PHOTO',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          else if (state is ImageUploaded) {
            return Center(
              child: Container(
                  width: 300.0,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 150.0),
                      Center(
                          child: Text(
                        "TAP TO UPLOAD NEW PHOTO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xff09245f)),
                      )),
                      SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () => {_showDialog(context)},
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff09245f), width: 1)),
                          child: FittedBox(
                            child:
                                Hero(tag: 'img', child: Image.file(imageFile)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      FlatButton(
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          mainBloc.add(ScanningEvent(imageFile));
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Color(0xff09245f),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              Text('SCAN PHOTO',
                                  style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          } else if (state is ImageScanning) {
            return LoadingPage(imageFile, mainBloc);
          } else if (state is ImageScanned) {
            return ResultPage(imageFile, state, mainBloc);
          } else
            return Center(
                child: Column(
              children: <Widget>[
                Text("Can't find location."),
                RaisedButton(
                  child: Text("BACK TO HOME"),
                  onPressed: () => {mainBloc.add(NewScanEvent())},
                )
              ],
            ));
        },
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  final File imageFile;
  final MainBloc mainBloc;

  LoadingPage(this.imageFile, this.mainBloc);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Hero(
            tag: 'title',
            child: Text(
              "Searching for location...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Stack(children: <Widget>[
            Container(
                height: 250,
                width: 250,
                child: FittedBox(
                  child: Hero(
                    tag: 'img',
                    child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(imageFile.path)),
                  ),
                )),
          ]),
          SizedBox(
            height: 80,
          ),
          Container(
            height: 20,
            width: 250,
            child: LinearProgressIndicator(),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              mainBloc.add(NewScanEvent());
            },
            child: Container(
              width: 200,
              height: 30,
              decoration: const BoxDecoration(
                  color: Color(0xff09245f),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child:
                  Center(child: Text('CANCEL', style: TextStyle(fontSize: 15))),
            ),
          ),
        ],
      ),
    );
  }
}
