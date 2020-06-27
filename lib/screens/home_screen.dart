import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchtogo/MainBloc.dart';
import 'package:searchtogo/animation/FadeAnimation.dart';
import 'package:searchtogo/screens/favorites_screen.dart';
import 'package:searchtogo/screens/info_screen.dart';
import 'package:searchtogo/screens/result_screen.dart';
import 'package:searchtogo/screens/welcome_screen.dart';

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
            return FadeIn(
              0.1,
              AlertDialog(
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
                            mainBloc.add(UploadedEvent(imageFile));
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
                            mainBloc.add(UploadedEvent(imageFile));
                          }
                        },
                      )
                    ])),
              ),
            );
          });
    }

    return Container(
      child: BlocBuilder<MainBloc, HomeState>(
        builder: (context, state) {
          if (state is StartState) {
            return WelcomePage(mainBloc);
          }
          if (state is InfoState) {
            return InfoPage(mainBloc);
          }
          if (state is FavoriteState) {
            return FavoritesPage(state.getFavorites, mainBloc);
          }
          if (state is NotUploaded)
            return Column(
              children: <Widget>[
                Center(
                  child: Container(
                    height: 500.0,
                    child: Stack(
                      children: <Widget>[
                        Image.asset('assets/images/bg-1.png'),
                        FadeRight(
                            0.5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    color: Colors.white,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      mainBloc.add(StartEvent());
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    color: Colors.white,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print("hello");
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 250.0),
                          child: Center(
                            child: Text("UPLOAD PHOTO",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontFamily: 'Coolvetica',
                                    color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 200.0),
                          child: Center(
                            child: Text("Tap the square to upload photo",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Coolvetica',
                                    color: Colors.white)),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: (MediaQuery.of(context).size.width / 2) - 150.0,
                          child: GestureDetector(
                            onTap: () => {_showDialog(context)},
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff09245f), width: 3)),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 100.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FlatButton(
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text('Please upload photo before scanning.'),
                    ));
                  },
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        Text('SCAN PHOTO',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          else if (state is ImageUploaded) {
            return Column(
              children: <Widget>[
                Center(
                  child: Container(
                    height: 500.0,
                    child: Stack(
                      children: <Widget>[
                        Image.asset('assets/images/bg-1.png'),
                        FadeRight(
                            0.5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    color: Colors.white,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      mainBloc.add(StartEvent());
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    color: Colors.white,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print("hello");
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 250.0),
                          child: Center(
                            child: Text("UPLOAD PHOTO",
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
                                "Tap the section again to upload other photo",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Coolvetica',
                                    color: Colors.white)),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: (MediaQuery.of(context).size.width / 2) - 150.0,
                          child: GestureDetector(
                            onTap: () => {_showDialog(context)},
                            child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff09245f), width: 3)),
                                child: FittedBox(
                                  child: Hero(
                                      tag: 'input',
                                      child: Image.file(imageFile)),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FlatButton(
                  onPressed: () {
                    mainBloc.add(ScanningEvent(imageFile));
                  },
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Color(0xff09245f),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        Text('SCAN PHOTO',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ImageScanning) {
            return LoadingPage(imageFile, mainBloc);
          } else if (state is ImageScanned) {
            return ResultPage(imageFile, state, mainBloc);
          } else
            return Center(
                child: Column(
              children: <Widget>[
                SizedBox(height: 150.0,),
                Text("Can't find location.",style: TextStyle(fontSize: 30.0, fontFamily: 'Coolvetica'),),
                SizedBox(height:30.0),
                Container(
                    width: 300,
                    height: 300,
                    child: FittedBox(
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(imageFile.path)),)
                ),
                SizedBox(height:30.0),
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
                        child: Text('TRY AGAIN',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff092460),
                                fontWeight: FontWeight.bold)),
                      )),
                ),
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
    return Column(
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
                    child: Text("SCANNING PHOTO",
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Coolvetica',
                            color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 200.0),
                  child: Center(
                    child: Text("We're currently processing your image",
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
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            height: 15.0,
            child: LinearProgressIndicator(
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        FlatButton(
          onPressed: () {
            mainBloc.add(NewScanEvent());
          },
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: 200,
            height: 50,
            decoration: const BoxDecoration(
                color: Color(0xff09245f),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Center(
              child: Text('CANCEL',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
