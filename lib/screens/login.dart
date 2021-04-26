import 'package:get/get.dart';
import 'package:socialtinder/const/color.dart';
import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:socialtinder/widgets/textfield.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
             Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(image:DecorationImage(image:AssetImage("asset/palm.jpg"),fit: BoxFit.cover)),  
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
                      GestureDetector(
                onTap: (){
                      final FormState formState =
                                      _.formKeyLogIn.currentState;
                                  if (formState.validate()) {
                                    print('Form is validate');
                                    _.logIn();
                                  } else {
                                    print('Form is not Validate');
                                  }
                },
                              child: Container(
                 
                  height: 50,width: 100,
                   color: colorDark,
                  child: Center(child:Text("Login",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),)),),
              )
            ]),
          )
              
              ),
                       ),
        ],);
        })
     
        
      ),
          
      
   
   
    );
  }
}