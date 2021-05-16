import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/widgets/button_widget.dart';
import 'package:socialtinder/widgets/space_widget.dart';
import 'package:socialtinder/widgets/textfield.dart';


class EditName extends StatefulWidget {
  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  File pickedImage;
  File pickedCoverImage;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    UserController userController = Get.put(UserController());

    // User  user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Edit Profile"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: GetBuilder<UserController>(
          builder: (_) {
            return Container(
              child: SingleChildScrollView(
                child: Form(
                  key: _.formKeySignUp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
/* ------------------------------- new ui data ------------------------------ */
                                   textField(
                                          editingController: _.editController,
                                          hintText: "Passord",
                                         prefixicon:Icon(Icons.lock_outline,color: Colors.black,),
                                           textInputType:TextInputType.visiblePassword,
                                          validator: (input){
                                              
                                      if (input.isEmpty) {
                                        return 'Please Enter Password';
                                      } 
                                 
                                   
                         },

                                        ),
                      spc20,
                   
                 
                      // textBox(
                      //   controller: _.emailController,
                      //   hint: 'Email',
                      //   validator: (input) {
                      //     if (input.isEmpty) {
                      //       return 'Please Enter a Email';
                      //     } else if (!RegExp(
                      //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //         .hasMatch(input)) {
                      //       return 'Please Enter a Valid Email';
                      //     }
                      //   },
                      //   onSave: (input) {
                      //     _.userData.email = input;
                      //   },
                      // ),
                      // spc20,
                      // textBox(
                      //     hint: 'Password',
                      //     validator: (input) {
                      //       if (input.length < 8) {
                      //         return 'Password Should be  Contain Atleast 8 digit';
                      //       }
                      //     },
                      //     controller: _.passwordController),
                      // spc20,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      //   child: Container(
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text('Date Of Birth'),
                      //         Text(
                      //           _.userData.dob ?? 'Select Date',
                      //           style: TextStyle(
                      //             color: _.userData.dob == null
                      //                 ? Colors.red
                      //                 : Colors.black,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // spc20,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      //   child: Container(
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text('Gender'),
                      //         Text(_.gender),
                      //         DropdownButton(
                      //           iconSize: 30,
                      //           items: <String>['Male', 'Female', 'Other']
                      //               .map((String value) {
                      //             return new DropdownMenuItem<String>(
                      //               value: value,
                      //               child: new Text(value),
                      //             );
                      //           }).toList(),
                      //           onChanged: (selectedVal) {
                      //             _.gender = selectedVal;
                      //             _.update();
                      //             _.userData.gender = selectedVal;
                      //           },
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // spc20,

                      /*-----------  Info------------*/
                      // textBox(
                      //   controller: _.countryController,
                      //   hint: _.userData.country,
                      //   validator: (input) {
                      //     if (input == '') {
                      //       return 'Please Enter Country Name';
                      //     }
                      //   },
                      //   onSave: (input) {
                      //     _.userData.country = input;
                      //   },
                      // ),
                      // spc20,
                      // textBox(
                      //   controller: _.stateController,
                      //   hint: _.userData.state,
                      //   validator: (input) {
                      //     if (input == '') {
                      //       return 'Please Enter State';
                      //     }
                      //   },
                      //   onSave: (input) {
                      //     _.userData.state = input;
                      //   },
                      // ),
                      // spc20,
                      // textBox(
                      //   hint: _.userData.profession,
                      //   controller: _.professionController,
                      //   validator: (input) {
                      //     if (input == '') {
                      //       return 'Enter Your Profession';
                      //     }
                      //   },
                      //   onSave: (input) {
                      //     _.userData.profession = input;
                      //   },
                      // ),
                      // spc20,
                      buttonBox(
                        txt: 'Update Profile',
                        onTap: () {
                          if (_.signup.username!= null 
                             ) {
                            userController.updateName();
                            Get.back();
                          }
                          print("Done");
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }, // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
