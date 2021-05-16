import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:socialtinder/const/color.dart';
import 'package:socialtinder/controller/loading_controller.dart';
import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:socialtinder/screens/homepage.dart';
import 'package:socialtinder/widgets/textfield.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool  _isSigningIn =  false;
   Loader loader  = Get.put(Loader());
  UserController userController  = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
       appBar: AppBar(
         title:Text("Login",style:TextStyle(color: colorDark),),
         backgroundColor: Colors.yellow[400],
       ),
       

          body:      
            Container(
        height: Get.height,
        width: Get.width,

        child: 
        GetBuilder<UserController>(builder: (_){
          return 
             Container(
               height: Get.height,
               width: Get.width,
               child: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                decoration: BoxDecoration(image:DecorationImage(image:AssetImage("assets/palm.jpg"),fit: BoxFit.cover)),  
                ),
                
                ),
                 
                         SingleChildScrollView(
                                                  child: Positioned(
            top: 30,
            left: 20,
            right: 20,
            bottom: 20,

           
            child:
          Form(
            key:  _.formKeyLogIn,
                        child: Column(children:[
                SizedBox(height:100),
                      
                     Padding(
                        padding: const EdgeInsets.symmetric(horizontal:40.0),
                                        child: 
                                        textField(
                                          editingController: _.emailController,
                                          hintText: "Email",
                                         prefixicon:Icon(Icons.email,color: Colors.black,),
                                           textInputType:TextInputType.emailAddress,
                                          validator: (input){
                             
                                      if (input.isEmpty) {
                                        return 'Please Enter a Email';
                                      } else if (!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(input)) {
                                        return 'Please Enter a Valid Email';
                                      }
                         },

                                        ),
                      
                     ),
                      SizedBox(height: 15,),
                             Padding(
                        padding: const EdgeInsets.symmetric(horizontal:40.0),
                                        child: 
                                        textField(
                                          editingController: _.passowrdController,
                                          hintText: "Passord",
                                         prefixicon:Icon(Icons.lock_outline,color: Colors.black,),
                                           textInputType:TextInputType.visiblePassword,
                                          validator: (input){
                                              
                                      if (input.isEmpty) {
                                        return 'Please Enter Password';
                                      } 
                                 
                                   
                         },

                                        ),
                      
                     ),
                     SizedBox(height:20),

                                 Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white,)
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async{
               
                setState(() {
                  _isSigningIn = true;
                  
                });
         
             User user = await _.signInWithGoogle();
            
                
                // TODO: Add a method call to the Google Sign-In authentication

                setState(() {
                  _isSigningIn = false;
                });
                 if(user != null){
                   Get.to(HomePage());
                 }
                

              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/googlelogo.png"),
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            
               ),
 SizedBox(height: 40),

                        Positioned(
                           top: 100,
                           left:10,
                           right: 10,
                           bottom: 10,
                                                  child: GestureDetector(
                  onTap: (){
                          final FormState formState =
                                          _.formKeyLogIn.currentState;
                                      if (formState.validate()) {
                                        print('Form is validate');
                                        // loader.loadingShow();
                                        _.logIn();
                                      } else {
                                        print('Form is not Validate');
                                      }
                  },
                                  child: Container(
                   
                    height: 50,width: 100,
                     color: colorDark,
                    child: Center(child:Text("Login",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),)),),
                ),
                        )
            ]),
          )
                
                ),
                         ),
        ],),
             );
        })
     
        
      ),
          
      
   
   
    );
  }
}