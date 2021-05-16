
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  // Variables
  final String svgName;
  final String text;

  const NoData({@required this.svgName, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/search.png", width: 100, height: 100,
          color: Theme.of(context).primaryColor),
          Text(text, style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center),
        ],
      ),
    );
  }
}