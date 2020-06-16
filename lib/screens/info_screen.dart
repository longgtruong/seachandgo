import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:searchtogo/models/infolinks.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  Color bg;

  _openURL(String link) async {
    bg = Colors.black12;
    print("clicked");
    var url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not open url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Stack(
              children: <Widget>[
                Image.asset('assets/images/bg-1.png'),
                Positioned(
                  bottom: 30.0,
                  left: MediaQuery.of(context).size.width/2-40,
                  child:Text("Info", style: TextStyle(fontSize: 75, fontFamily: 'Coolvetica',color: Colors.white)),
                )
              ]
            ),
          ),
          SizedBox(height:15.0),
          Container(
            height: 250.0,
            width: 300,
            child: ListView.builder(
              itemCount: links.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 4
                  ),
                  child: Material(
                    color: bg,
                    child: ListTile(
                      onTap: () => _openURL(links[index].url),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 0
                        ),
                        child: Text(links[index].name,style: TextStyle(color: Colors.blue),),
                      ),
                    ),
                  ),
                );
              },
            )
          ),
          SizedBox(height:20.0),
          FlatButton(
            onPressed: () {

            },
            child: Container(
              width: 200,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                  BorderRadius.all(Radius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                      FontAwesomeIcons.solidAddressCard,
                      color: Colors.white,
                  ),
                  Text('CONTACT US',
                      style: TextStyle(
                          fontSize: 15, color: Colors.white)),
                ],
              ),
            ),
          )
        ]
      ),
    );
  }
}
