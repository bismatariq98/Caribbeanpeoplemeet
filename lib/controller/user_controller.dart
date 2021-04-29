import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:socialtinder/controller/loading_controller.dart';
import 'package:socialtinder/main.dart';

import 'package:flutter/material.dart';
import 'package:socialtinder/screens/homepage.dart';
import 'package:socialtinder/screens/signup.dart';
import 'package:socialtinder/user_model.dart/signUpModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialtinder/user_model.dart/signUpModel.dart'; 
import 'package:google_sign_in/google_sign_in.dart';
class UserController extends GetxController {

   bool switches =  true;

  Color colorblack = Colors.black;

 Color colorwhite = Colors.white;





   Loader loader  = Get.put(Loader());

  String currentUserId;
    final formKeySignUp = GlobalKey<FormState>();
    final formKeyLogIn = GlobalKey<FormState>();
      List selectedAnimals2 = [];//ya vali
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
     signup.userId = currentUserId;
   List listForSave=[];
   for(var i=0;i<selectedAnimals2.length;i++){
     listForSave.add(selectedAnimals2[i].name);
   }
     
    firebaseFirestore.collection("Users").doc(currentUserId).set({
      'userId':currentUserId,
    'email':signup.email,
    'username':signup.username,
   'nationality': listForSave 

  }
  
  );
    return true;

   }
   Future logIn() async {
     loader.loadingShow();
     UserCredential userCredential;
  try{
    userCredential = await firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passowrdController.text);
     loader.loadingDismiss();
     Get.snackbar("Login", "Login Successfully");
    //  clearForm();
     Get.to(HomePage());
  }
  catch(e) {
    loader.loadingDismiss();
    update();
    Get.snackbar("Error","There is error");
  }
   

   }

   Future signUp () async {
     loader.loadingShow();
           signup.email = emailController.text;
           signup.username = userNameController.text;

           
            try{
     var user = await firebaseAuth.createUserWithEmailAndPassword(email: signup.email, password: passowrdController.text);
      currentUserId = user.user.uid;

            addUserData().then((value) {
                loader.loadingDismiss();
               Get.snackbar("Success", "User SignUp successfully");
              //  clearForm();
            });
    
            }
            catch(e){
                loader.loadingDismiss();
                update();
                 Get.snackbar("Error", "Sign Up not Success");
                 print(e);
               

            }

   }  

     signout() {
    firebaseAuth.signOut();
    Get.offAll(MyHomePage());
  }

  //Google sign In
  
Future<User> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
        Get.snackbar("Account Exsist","Account already exsist ");
        }
        else if (e.code == 'invalid-credential') {
          Get.snackbar("Invalid Crediential","Invalid Crediantial");
        }
      } catch (e) {
       Get.snackbar("Error","Error + $e");
      }
    }

    return user;
  }

    




}