import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:socialtinder/screens/edit_name.dart';
import 'package:socialtinder/widgets/common_widget.dart';
import 'package:socialtinder/widgets/edit_button.dart';
import 'package:socialtinder/widgets/separator_widget.dart';
import 'package:socialtinder/widgets/space_widget.dart';



class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
   
   @override
   void initState() { 
     super.initState();
     userController.getData();
   }

  UserController userController = Get.put(UserController());


   void _showPicker() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Edit UserName'),
                        onTap: () {
                          Get.to(EditName())
                              .then((value) => Navigator.of(context).pop());
                        }),
                 
                  ],
                ),
              ),
            );
          });
    }

    _imgFromCamera(String photoPic) async {
      final pickedFile = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 50);

      setState(() {
        if (pickedFile != null) {
       
             userController.profilePhoto = File(pickedFile.path);
             
         
               userController.uploadFile();
             
        }
      });
    }

    _imgFromGallery(String photoPic) async {
      final pickedFile = await ImagePicker()
          .getImage(source: ImageSource.gallery, imageQuality: 50);

      setState(() {
     if (pickedFile != null) {
       
             userController.profilePhoto = File(pickedFile.path);
             
         
               userController.uploadFile();
             
        }
      });
    }

    void _showPickerImage(String photo) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery(photo);
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        _imgFromCamera(photo);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }
  @override
  Widget build(BuildContext context) {
    return 
     GetBuilder<UserController>(builder: (_) {
      return SingleChildScrollView(
          child: Column(
        children: <Widget>[
         Container(
            height: 250.0,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 180.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: 
                                  // NetworkImage(
                                  //     userController.signup.coverPhoto == ''
                                  //         ? ''
                                  //         : userController.signup.coverPhoto
                                          
                                  //         ),
                                  AssetImage("assets/googlelogo.png"),
                                  fit: BoxFit.fitWidth),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: Get.width / 7,
                        child: GestureDetector(
                          onTap: () {
                            _showPickerImage("coverPhoto");
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: Colors.grey[200],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            _.signup.profilePhoto ?? ''),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _showPickerImage("profilePhoto");
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        child: Text(
                            '${_.signup.firstName} ${_.signup.lastName}' ==
                                    null
                                ? "helo"
                                : '${_.signup.firstName} ${_.signup.lastName}',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
             Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),
                infoRow('Gender', _.signup.gender),
                spc20,
                infoRow('Date of Birth', _.signup.age),
                spc20,
                infoRow('Email', _.signup.email),
                // spc20,
                // infoRow('Country', _.userData.country),
                // spc20,
                // infoRow('State', _.userData.state),
                // spc20,
                // infoRow('Profession', _.userData.profession),
                // spc20,
                SizedBox(height: 15.0),
                InkWell(
                  onTap: () {
                    // Get.to(EditProfile());
                    _showPicker();
                  },
                  child: editButton("own", "Send Message"),
                  // Container(
                  //   height: 40.0,
                  //   decoration: BoxDecoration(
                  //     color: Colors.lightBlueAccent.withOpacity(0.25),
                  //     borderRadius: BorderRadius.circular(5.0),
                  //   ),
                  //   child: Center(
                  //       child: Text('Edit Public Details',
                  //           style: TextStyle(
                  //               color: Colors.blue,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 16.0))),
                  // ),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Column(
          //     children: <Widget>[
          //       SizedBox(height: 15.0),
          //       infoRow('Gender', _.signup.nationality),
          //       spc20,
              
          //       infoRow('Email', _.signup.email),
          //       spc20,
               
          //       SizedBox(height: 15.0),
          //       InkWell(
          //         onTap: () {
          //           // Get.to(EditProfile());
          //           _showPicker();
          //         },
          //         child: editButton("own", "Send Message"),
          //         // Container(
          //         //   height: 40.0,
          //         //   decoration: BoxDecoration(
          //         //     color: Colors.lightBlueAccent.withOpacity(0.25),
          //         //     borderRadius: BorderRadius.circular(5.0),
          //         //   ),
          //         //   child: Center(
          //         //       child: Text('Edit Public Details',
          //         //           style: TextStyle(
          //         //               color: Colors.blue,
          //         //               fontWeight: FontWeight.bold,
          //         //               fontSize: 16.0))),
          //         // ),
          //       ),
          //     ],
          //   ),
          // ),
//
          // Divider(height: 40.0),

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Column(
          //     children: <Widget>[
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //           Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Text('Friends',
          //                   style: TextStyle(
          //                       fontSize: 22.0, fontWeight: FontWeight.bold)),
          //               SizedBox(height: 6.0),
          //               Text('536 friends',
          //                   style: TextStyle(
          //                       fontSize: 16.0, color: Colors.grey[800])),
          //             ],
          //           ),
          //           Text('Find Friends',
          //               style: TextStyle(fontSize: 16.0, color: Colors.blue)),
          //         ],
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 15.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/samantha.jpg')),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Samantha',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/andrew.jpg')),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Andrew',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/Sam Wilson.jpg'),
          //                           fit: BoxFit.cover),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Sam Wilson',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 15.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/steven.jpg')),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Steven',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/greg.jpg')),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Greg',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   height: MediaQuery.of(context).size.width / 3 - 20,
          //                   width: MediaQuery.of(context).size.width / 3 - 20,
          //                   decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                           image: AssetImage('assets/andy.jpg'),
          //                           fit: BoxFit.cover),
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                 ),
          //                 SizedBox(height: 5.0),
          //                 Text('Andy',
          //                     style: TextStyle(
          //                         fontSize: 16.0, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         margin: EdgeInsets.symmetric(vertical: 15.0),
          //         height: 40.0,
          //         decoration: BoxDecoration(
          //           color: Colors.grey[300],
          //           borderRadius: BorderRadius.circular(5.0),
          //         ),
          //         child: Center(
          //             child: Text('See All Friends',
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 16.0))),
          //       ),
          //     ],
          //   ),
          // ),
          // SeparatorWidget()
        ],
      ));
    });
  }
}