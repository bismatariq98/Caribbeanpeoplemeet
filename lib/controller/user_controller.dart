import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:socialtinder/main.dart';

import 'package:flutter/material.dart';
import 'package:socialtinder/screens/homepage.dart';
import 'package:socialtinder/screens/signup.dart';
import 'package:socialtinder/user_model.dart/signUpModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialtinder/user_model.dart/signUpModel.dart'; 
class UserController extends GetxController {
  String currentUserId;
    final formKeySignUp = GlobalKey<FormState>();
    final formKeyLogIn = GlobalKey<FormState>();
      List<Animal> selectedAnimals2 = [];
  TextEditingController emailController =  TextEditingController();
   TextEditingController passowrdController =  TextEditingController();
    TextEditingController userNameController =  TextEditingController();
    User user;

 FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   
clearForm(){
  
  emailController.clear();
  passowrdController.clear();
  userNameController.clear();

}
  SignUp signup  = SignUp();
   
  
   Future addUserData() async{
   
     
    firebaseFirestore.collection("Users").doc(currentUserId).set({
    'email':signup.email,
    'username':signup.username,
   'nationality': selectedAnimals2

  }
  
  );
    return true;

   }
   Future logIn() async {
     
     UserCredential userCredential;
  try{
    userCredential = await firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passowrdController.text);
     Get.snackbar("Login", "Login Successfully");
     clearForm();
     Get.to(HomePage());
  }
  catch(e) {
    Get.snackbar("Error","There is error");
  }
   

   }

   Future signUp () async {
           signup.email = emailController.text;
           signup.username = userNameController.text;
           
            try{
     var user = await firebaseAuth.createUserWithEmailAndPassword(email: signup.email, password: passowrdController.text);
      currentUserId = user.user.uid;

            addUserData().then((value) {
               Get.snackbar("Success", "User SignUp successfully");
               clearForm();
            });
    
            }
            catch(e){
                 Get.snackbar("Error", "Sign Up not Success");
                 print(e);

            }
           
    
          
         


   }  

   signOut() async {
    await  firebaseAuth.signOut();
    
   }


}