import 'package:flutter/foundation.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp {
  
  String email;
  
  String username;
  List nationality  = [];

  SignUp({this.email,this.nationality,this.username});


   factory SignUp.fromDocumentSnapshot(DocumentSnapshot doc) => SignUp(
     
      email: doc.data()["Email"],
      username: doc.data()["Username"],
      nationality: doc.data()["Nationality"],

      );

  Map<String, dynamic> toMap() => {
      
        "Email": email,
        "Username": username,
        "Nationality": nationality,

      };
}

 