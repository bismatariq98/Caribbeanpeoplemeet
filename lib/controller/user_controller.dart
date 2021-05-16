import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:socialtinder/controller/loading_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:socialtinder/screens/Choose_photo_screen.dart';
import 'package:socialtinder/screens/homepage.dart';

import 'package:socialtinder/user_model.dart/signUpModel.dart';


import 'package:google_sign_in/google_sign_in.dart';
class UserController extends GetxController {

   bool switches =  true;

  Color colorblack = Colors.black;

 Color colorwhite = Colors.white;


DateTime selectedDate = DateTime.now().subtract(Duration(days: 6570));
String gender = 'Male';


   Loader loader  = Get.put(Loader());
 File coverPhoto;
  File profilePhoto;
  String currentUserId;
    final formKeySignUp = GlobalKey<FormState>();
    final formKeyLogIn = GlobalKey<FormState>();
      List selectedAnimals2 = [];//ya vali
      List<SignUp> signupList = [];
  TextEditingController emailController =  TextEditingController();
   TextEditingController passowrdController =  TextEditingController();
    TextEditingController userNameController =  TextEditingController();
    TextEditingController editController =  TextEditingController();
     TextEditingController firstNameController =  TextEditingController();
      TextEditingController lastNameController =  TextEditingController();
 

    User user;

 FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //   clearUserData() {
  //   friendRequestList.clear();
  //   friendsList.clear();
  //   requestSentList.clear();
  // }
clearForm(){
  
  emailController.clear();
  passowrdController.clear();
  userNameController.clear();

}
  SignUp signup  = SignUp();
   
   updateDislikeData({String userId,Map<String,dynamic> data})async {
    await FirebaseFirestore.instance.collection("Users").doc(userId).update(data);

   }

     updatelikeData({String userId,Map<String,dynamic> data})async {
    await FirebaseFirestore.instance.collection("Users").doc(userId).update(data);

   }


     Future updateName() async {
    loader.loadingShow();
    signup.username= editController.text;

    
    var userId = firebaseAuth.currentUser.uid;
    await firebaseFirestore.collection('Users').doc(userId).update({
      "username": signup.username,
  
    }).then((value) {
      loader.loadingDismiss();
      update();
    });

    return true;
  }
   
   Future getDataDating()async {
     signup = SignUp();
var userId = firebaseAuth.currentUser.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("Users")
        .get()
        .then((QuerySnapshot value) {
          if(value.docs.length >0){
            signupList.clear();
                value.docs.forEach((element) {
                 signupList.add(SignUp.fromDocumentSnapshot(element));
                 print(signupList.length);
                });
update();   
          }
             
        });    
    // clearUserData();
    // getAdditionalData();
   }


  Future getData() async {
    signup = SignUp();

    var userId = firebaseAuth.currentUser.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("Users")
        .doc(userId)
        .get()
        .then((value) => signup =SignUp.fromDocumentSnapshot(value));
                
                // signupList.add(signup);
          
    // clearUserData();
    // getAdditionalData();
                  
    update();
  }

  Future addProfileCover(String link) async {
    var userId = firebaseAuth.currentUser.uid;
    await firebaseFirestore.collection('Users').doc(userId).update({
      "coverPhoto": "$link",
    }).then((value) => getData());
    loader.loadingDismiss();
    update();
    return true;
  }
  //   Future uploadFileCover() async {
  //   var userId = firebaseAuth.currentUser.uid;
  //   loader.loadingShow();
  //   final firebase_storage.Reference storageReference = firebase_storage
  //       .FirebaseStorage.instance
  //       .ref()
  //       .child("coverPhotos/$userId/coverPhoto+userId.jpg");

  //   final firebase_storage.UploadTask uploadTask =
  //       storageReference.putData(profilePhoto.readAsBytesSync());
  //   await uploadTask.whenComplete(() {
  //     storageReference.getDownloadURL().then((value) {
  //       print(value);
  //       return addProfileCover(value);
  //     });
  //     update();
  //   });
  // }
  Future addProfile(String link) async {
    var userId = firebaseAuth.currentUser.uid;

    await firebaseFirestore.collection('Users').doc(userId).update({
      "profilePhoto": "$link",
      "age":signup.age,
      "gender":gender,
    }).then((value) => getData());
    loader.loadingDismiss();
    update();
    return true;
  }



     Future uploadFile() async {
    var userId = firebaseAuth.currentUser.uid;
    loader.loadingShow();
    final firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("profilePhotos/$userId/profilePhoto+userId.jpg");

    final firebase_storage.UploadTask uploadTask =
        storageReference.putData(profilePhoto.readAsBytesSync());
    await uploadTask.whenComplete(() {
      storageReference.getDownloadURL().then((value) {
        print(value);
        return addProfile(value);
      });
      update();
    });
  }
  
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
   'nationality': listForSave,
   'firstName':signup.firstName,
   'lastName':signup.lastName,
   'age':"",
   'gender':"",
   'profilePhoto':"",
   'userTotalDisliked':"",
   'userTotalLiked':"",
    'userTotalVisits':"",

  }
  
  );
    return true;

   }
   Future logIn() async {
     loader.loadingShow();
     UserCredential userCredential;
  try{
    userCredential = await firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passowrdController.text);
    getData().then((value) {
  loader.loadingDismiss();
     Get.snackbar("Login", "Login Successfully");
    //  clearForm();
     Get.to(HomePage());
    });
   
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
           signup.firstName = firstNameController.text;
           signup.lastName = lastNameController.text;
           
           
            try{
     var user = await firebaseAuth.createUserWithEmailAndPassword(email: signup.email, password: passowrdController.text);
      currentUserId = user.user.uid;

            addUserData().then((value) {

                loader.loadingDismiss();
                Get.to(ChoosePhotoScreen());
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