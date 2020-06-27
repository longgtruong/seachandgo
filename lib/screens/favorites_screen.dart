import 'package:flutter/material.dart';
import 'package:searchtogo/animation/FadeAnimation.dart';
import 'package:searchtogo/models/tuidestinations.dart';
import 'package:searchtogo/screens/destination_screen.dart';

import '../MainBloc.dart';

class FavoritesPage extends StatefulWidget {
  List<TUIDestination> favorites;
  final MainBloc mainBloc;

  FavoritesPage(this.favorites, this.mainBloc);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    List<TUIDestination> destinations = widget.favorites;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Expanded(
              child: Container(
                height: 732.0,
                child: Stack(children: <Widget>[
                  Center(
                    child: Padding(
                      padding:EdgeInsets.only(top:200.0),
                      child: Container(
                          height: 700.0,
                          width: 300,
                          child: ListView.builder(
                            itemCount: destinations.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Material(
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(context,
                                        MaterialPageRoute(builder: (_) => DestinationPage(destinations[index],widget.mainBloc))),
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 0),
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              child: Hero(
                                                tag:destinations[index].getLabel,
                                                child: Image.asset(
                                                  'assets/images/' + destinations[index].getLabel + '.jpg',
                                                  fit: BoxFit.cover,
                                                  height: 150.0,
                                                  width: 300.0,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5.0,
                                              left: 10.0,
                                              child: Text(
                                                destinations[index].getLabel,
                                                style: TextStyle(color: Colors.white,fontFamily: 'Coolvetica', fontSize: 30.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                  ),
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
                                widget.mainBloc.add(StartEvent());
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
                  FadeRight(
                      0.5,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 450.0),
                        child: Center(
                          child: Text("FAVORITES",
                              style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: 'Coolvetica',
                                  color: Colors.white)),
                        ),
                      ))
                ]),
              ),
            ),
          ),
        ]);
  }
}
