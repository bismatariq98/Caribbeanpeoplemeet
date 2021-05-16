import 'package:flutter/foundation.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp {
  String userId;
  String email;
  
  String username;
  List nationality  = [];
  String profilePhoto;
  String coverPhoto;
  String firstName;
  String lastName;
  String age;
  String gender;
  String userTotalLikes;
  String userTotalVisits;
  String userTotalDisliked;

  SignUp({this.email,this.nationality,this.username,this.userId,this.profilePhoto,this.coverPhoto,this.age,this.firstName,this.lastName,this.gender,this.userTotalDisliked,this.userTotalLikes,this.userTotalVisits});

     



   factory SignUp.fromDocumentSnapshot(DocumentSnapshot doc) => SignUp(
      userId: doc.data()["userId"],
      email: doc.data()["email"],
      username: doc.data()["username"],
      nationality: doc.data()["nationality"],
      profilePhoto: doc.data()["profilePhoto"],
      coverPhoto:doc.data()["coverPhoto"],
      firstName: doc.data()["firstName"],
      lastName: doc.data()["lastName"],
      age:doc.data()["age"],
      gender:doc.data()["gender"],
      userTotalDisliked: doc.data()["userTotalDisliked"],
      userTotalVisits: doc.data()["userTotalVisits"],
      userTotalLikes: doc.data()["userTotalLikes"],

      );

  Map<String, dynamic> toMap() => {
         "userId":userId,
        "email": email,
        "username": username,
        "nationality": nationality,
        "profilePhoto":profilePhoto,
        "coverPhoto":coverPhoto,
        "firstName":firstName,
        "lastName":lastName,
        "age":age,
        "gender":gender,
        "userTotalDisliked":userTotalDisliked,
        "userTotalVisits":userTotalVisits,
        "userTotalLikes":userTotalLikes,

      };
}

 