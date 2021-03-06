import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialtinder/screens/homepage.dart';
import 'package:socialtinder/screens/signup.dart';
import 'package:get/get.dart';
import 'package:socialtinder/screens/login.dart';
import 'package:lottie/lottie.dart';
void main()async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     var userId = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark,accentColor: Colors.red,primaryColor: Colors.lime),
      theme: ThemeData(brightness: Brightness.light,),

      title: 'Flutter Demo',
   
      home: userId != null ? HomePage():SplashScreen(),
    );
  }
}



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   
  @override
  Widget build(BuildContext context) {
    Timer(
            Duration(seconds: 6),
                () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => MyHomePage())));

    return Scaffold(
      backgroundColor: Colors.white,
          body: Container(
        height: Get.height,
        width: Get.width,
        child: Center(child: Lottie.asset("assets/cpm.json",repeat: false)),
        
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   



  // UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Color(0xff040404),
          body: Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/palm.jpg"),fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(
                    child: 
                 Container(
                   height: 190,
                 ),),
                SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () {
                    // userController.clearForm();
                    Get.to(SignUpScreen());
                 
                  },
                  child: Container(
                    height: 75,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Color(0xfff4f4f4),
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 8,
                      // ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                            
                            color: Color(0xffffd600),
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                  ),
                ),
                SizedBox(height:10),
                GestureDetector(
                  onTap: () {
                    // userController.clearForm();
                    // Navigator.push((context),
                    //     MaterialPageRoute(builder: (context) {
                    //   return 
                    //   // SplashScreen();
                    //   LoginScreen();
                    // }));
                    
                    Get.to(Login());
                  },
                  child: Container(
                    height: 75,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 8,
                      // ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ) 
          // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}


