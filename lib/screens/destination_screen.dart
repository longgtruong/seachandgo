
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:searchtogo/models/tuidestinations.dart';
import 'package:searchtogo/widget/WeatherBar.dart';
import 'package:url_launcher/url_launcher.dart';


import '../MainBloc.dart';

class DestinationPage extends StatefulWidget {

  final TUIDestination destination;
  final MainBloc mainBloc;

  DestinationPage(this.destination,this.mainBloc);

  TUIDestination get getDestination => destination;


  @override
  _DesinationPageState createState() => _DesinationPageState();
}

class _DesinationPageState extends State<DestinationPage> {

  Color _iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {

    _openURL(String link) async {
      var url = link;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Could not open url";
      }
    }

    TUIDestination destination = widget.destination;

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _openURL('https://www.tui.nl/vakantie/'+destination.getCountry+'/resultaten/');
          },
          label: Container(
            child: Center(child: Text("BOOK NOW")),
            width: 300.0,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: DraggableScrollableSheet(
        minChildSize: 1,
        initialChildSize: 1,
        builder: (context, scrollController) {
          return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.white],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        height: 400.0,
                        width: MediaQuery.of(context).size.width,
                        child: Hero(
                          tag: destination.getLabel,
                          child: Image.asset(
                            'assets/images/'+destination.getLabel+'.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 400.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.grey.withOpacity(0.0),
                                  Colors.black,
                                ],
                                stops: [
                                  0.0,
                                  1.0
                                ])),
                      ),
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
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                              icon: FaIcon(FontAwesomeIcons.solidHeart),
                              color: _iconColor,
                              iconSize: 30.0,
                              onPressed: () {
                                setState(() {
                                  if (_iconColor==Colors.white) {
                                    _iconColor = Colors.lightGreen;
                                    widget.mainBloc.add(LikeEvent(destination));
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Container(height:20.0,child: Center(child:Text('Added to your favorites'))),
                                    ));
                                  } else if (_iconColor == Colors.lightGreen) {
                                    _iconColor = Colors.white;
                                    widget.mainBloc.add(UnlikeEvent(destination));
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Container(height:20.0,child: Center(child:Text('Removed from your favorites'))),
                                    ));
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 40.0,
                        left: 30.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              destination.getLabel,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Coolvetica',
                                  fontSize: 40.0),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                Text(
                                  destination.getCity+", "+destination.getCountry,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Coolvetica',
                                      fontSize: 20.0),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
                  ]),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Text(
                            "Types of vacation",
                            style:
                            TextStyle(fontFamily: 'Coolvetica', fontSize: 20.0),
                          ),
                        ),
                        SizedBox(height:15.0),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left:20.0),
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                color: Colors.grey,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.hotel,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:20.0),
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                color: Colors.grey,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(
                                      FontAwesomeIcons.shoppingBag,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:20.0),
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                color: Colors.grey,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.local_library,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Text(
                            "Details",
                            style:
                            TextStyle(fontFamily: 'Coolvetica', fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            destination.details,
                            style:
                            TextStyle(fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Text(
                            "Weather",
                            style:
                            TextStyle(fontFamily: 'Coolvetica', fontSize: 20.0),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        WeatherBar(destination.forecasts),
                        SizedBox(height: 80.0,)
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                  )
                ],
              ));
        },
      ),
    );
  }
}
