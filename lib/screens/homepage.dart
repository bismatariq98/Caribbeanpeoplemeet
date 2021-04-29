import 'dart:async';

import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:socialtinder/screens/tabs/social_tab.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserController userController = Get.put(UserController());
   

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

     
//      _getAddressFromLatLng() async {
//   try {
//     List<Placemark> p = await geolocator.placemarkFromCoordinates(
//         _currentPosition.latitude, _currentPosition.longitude);
//     Placemark place = p[0];
//     setState(() {
//       _currentAddress =
//       "${place.locality}, ${place.postalCode}, ${place.country}";
//     });
//   } catch (e) {
//     print(e);
//   }
// }

   _getCurrentLocation() {
  Geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
    setState(() {
      _currentPosition = position;
    
    });
     print(  _currentPosition.latitude);
    // _getAddressFromLatLng();
  }).catchError((e) {
    print(e);
  });
}
   
  //  runthis ()async {
  //    bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
  //     StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationOptions).listen(
  //   (Position position) {
  //       print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
  //   });
  //  }


  Position _currentPosition;
 
   
    List _tabs = <Widget>[
      
            SocialTab(),
                  Center(child: Text("hello Option")),
            Container(color: Colors.green,),
            Container(color: Colors.blue,),
          ];


String _currentAddress;
  
  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
      //  backgroundColor: userController.switches? userController.colorblack:userController.colorwhite,
      appBar: AppBar(
        title:Text("Home Screen"),
        actions: [
          IconButton(icon: Icon(Icons.emoji_emotions_rounded), onPressed: (){
            userController.signout();
          }),
            IconButton(icon: Icon(Icons.switch_account), onPressed: (){
             //yaha py krna
            
                // userController.switches ? userController.switchersfunc(false):userController.switchersfunc(true);
                
           
           
          }),
           IconButton(icon: Icon(Get.isDarkMode?Icons.wb_sunny: Icons.nights_stay),onPressed: (){Get.changeTheme(Get.isDarkMode?ThemeData.light(): ThemeData.dark());},),
           IconButton(icon: Icon(Icons.location_city), onPressed: (){
           _getCurrentLocation();
          })
        ],
      ),
       bottomNavigationBar: BottomNavyBar(
         backgroundColor: Get.isDarkMode?Colors.white:Colors.white ,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Social'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('Users'),
            activeColor: Colors.blueAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text(
              'Messages test for mes teset test test ',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
       body: _tabs[_currentIndex],
       
  //  PageView(
  //         controller: _pageController,
  //         onPageChanged: (index) {
  //           setState(() => _currentIndex = index);
  //         },
  //         children:
  //  <Widget>[
  //           Center(child: Text("hello")),
  //                 Center(child: Text("hello Option")),
  //           Container(color: Colors.green,),
  //           Container(color: Colors.blue,),
  //         ],
  //       ),
      );
    
  }
}