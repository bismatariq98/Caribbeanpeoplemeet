import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   UserController userController  = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title:Text("Home Screen"),
        actions: [
          IconButton(icon: Icon(Icons.emoji_emotions_rounded), onPressed: (){
            userController.signout();
          })
        ],
      ),
       
    );
  }
}