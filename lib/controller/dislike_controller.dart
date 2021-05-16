import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class DislikeController extends GetxController {
    
    UserController userController = Get.put(UserController());
      
      saveDislike( String dislikedUserId) async{
        
        await FirebaseFirestore.instance.collection("C_DISLIKES").add({
          "DISLIKED_USER_ID":dislikedUserId,
          "DISLIKED_BY_USER_ID":userController.currentUserId,
           "TIMESTAMP": FieldValue.serverTimestamp()
        }).then((_) => {
           userController.updateDislikeData(userId:userController.currentUserId,
           data:
             {"userTotalDisliked":FieldValue.increment(1).toString()},
           )
        });


      } 
       
  checkIfDisliked({String dislikedUserId}) async{
     try{
  await FirebaseFirestore.instance.collection("C_DISLIKES").
   where("DISLIKED_BY_USER_ID", isEqualTo: userController.currentUserId ).
   where("DISLIKED_USER_ID",isEqualTo:dislikedUserId ).get().then((QuerySnapshot querySnapshot) {
    if(querySnapshot.docs.isEmpty){
        saveDislike(dislikedUserId);
        print("Was not found");
    }
    else {
      print("Found Disliked Already");
    }
   });
     } 
     catch (e){
      print("This was the error"  '$e');       
  
     }


  }
  



}