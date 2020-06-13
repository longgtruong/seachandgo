import 'package:flutter/material.dart';
import 'package:searchtogo/models/infolinks.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  Color bg = null;
  List<String> tabs = ["hello","aaaa","abc"];

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
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 30,
              left: 20
          ),
          child: Container(
            width: 300,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black12,
                        width: 1
                    )
                )
            ),
            child: Row(
              children: <Widget>[
                Text("Info", style: TextStyle(fontSize: 50, fontFamily: 'Coolvetica'),),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20
          ),
          child: Container(
            height: 400,
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
                        child: Text(links[index].name),
                      ),
                    ),
                  ),
                );
              },
            )
          ),
        )
      ]
    );
  }
}
