import 'package:flutter/material.dart';

Widget editButton(String typeOf, String sendMessage) {
  return typeOf == "own"
      ? Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.25),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
              child: Text("Edit Profile",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0))),
        )
      : Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.25),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
              child: Text(sendMessage,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0))),
        );
}