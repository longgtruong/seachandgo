import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchtogo/MainBloc.dart';
import 'package:searchtogo/MainRepo.dart';
import 'package:searchtogo/screens/home_screen.dart';
import 'package:searchtogo/screens/info_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff09245f),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

  final tabs = [
    Homescreen(),
    InfoPage(),
    Center(child: Text("History")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MainBloc(HomeRepo()),
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            backgroundColor: Color(0xff09245f)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text("Info"),
              backgroundColor: Color(0xff09245f)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text("History"),
              backgroundColor: Color(0xff09245f)
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
