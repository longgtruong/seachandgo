import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:searchtogo/MainBloc.dart';
import 'package:searchtogo/animation/FadeAnimation.dart';
import 'package:searchtogo/models/infolinks.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  final MainBloc mainBloc;

  InfoPage(this.mainBloc);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Color bg;

  _openURL(String link) async {
    bg = Colors.black12;
    var url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not open url";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: 300.0,
              child: Stack(children: <Widget>[
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
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Center(
                        child: Text("INFO",
                            style: TextStyle(
                                fontSize: 35,
                                fontFamily: 'Coolvetica',
                                color: Colors.white)),
                      ),
                    ))
              ]),
            ),
          ),
          Container(
              height: 250.0,
              width: 300,
              child: ListView.builder(
                itemCount: links.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Material(
                      color: bg,
                      child: ListTile(
                        onTap: () => _openURL(links[index].url),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          child: Text(
                            links[index].name,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
          SizedBox(height: 20.0),
          FlatButton(
            onPressed: () {
              _openURL('https://www.tui.nl/contact/');
            },
            child: Container(
              width: 200,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.solidAddressCard,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5.0,),
                  Text('CONTACT US',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ],
              ),
            ),
          )
        ]);
  }
}
