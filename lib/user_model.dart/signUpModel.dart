import 'package:flutter/foundation.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp {
  String userId;
  String email;
  
  String username;
  List nationality  = [];

  SignUp({this.email,this.nationality,this.username,this.userId});


   factory SignUp.fromDocumentSnapshot(DocumentSnapshot doc) => SignUp(
      userId: doc.data()["userId"],
      email: doc.data()["Email"],
      username: doc.data()["Username"],
      nationality: doc.data()["Nationality"],

      );

  Map<String, dynamic> toMap() => {
         "userId":userId,
        "Email": email,
        "Username": username,
        "Nationality": nationality,

      };
}

 