import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:searchtogo/MainBloc.dart';
import 'package:searchtogo/widget/CarouselItem.dart';

import '../Result.dart';

class CarouselWithIndicator extends StatefulWidget {

  final ImageScanned state;
  CarouselWithIndicator(this.state);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {

  int _current = 0;

  @override
  Widget build(BuildContext context) {

    List<Result> results = widget.state.results;
    final List<Widget> imageSliders = results.map((result) => CarouselItem(result)).toList();

    return Column(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                height: 430.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: results.map((url) {
                int index = results.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ]
    );
  }
}


