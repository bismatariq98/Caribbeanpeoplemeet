import 'package:flutter/material.dart';

infoRow(heading, txt) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Text('$heading:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ),
      Expanded(flex: 2, child: Text(txt, style: TextStyle(fontSize: 16.0)))
    ],
  );
}
