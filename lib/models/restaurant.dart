import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RestaurantModel {
  
  String restaurantName;
  String restaurantAddress;
  String contactInfo;
  String lattitude;
  String longtitude;
  String id;
  DocumentReference ref;
  
RestaurantModel({this.contactInfo,this.id,this.lattitude,this.longtitude,this.restaurantAddress,this.restaurantName,this.ref});


  factory RestaurantModel.fromDocumentSnapShot(DocumentSnapshot doc) =>RestaurantModel(
      restaurantName: doc.data()["restaurantName"],
      restaurantAddress: doc.data()["restaurantAddress"],
      contactInfo: doc.data()["contactInfo"],
      lattitude: doc.data()["lattitude"],
      longtitude: doc.data()["longtitude"],
      id: doc.data()["id"],
      
      ref: doc.reference);

  Map<String, dynamic> toMap() => {
        restaurantName: restaurantName,
        restaurantAddress:restaurantAddress,
        contactInfo:contactInfo,
        lattitude:lattitude,
        longtitude:longtitude,
        id:id,
   
      };

}