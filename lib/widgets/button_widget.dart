import 'package:flutter/material.dart';

buttonBox(
    {txt,
    Color color = Colors.blueAccent,
    double height = 60.0,
    double width = 300.0,
    onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            '$txt',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    ),
  );
}
