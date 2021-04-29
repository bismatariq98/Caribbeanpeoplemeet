import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialtinder/const/color.dart';
import 'package:socialtinder/controller/loading_controller.dart';
import 'package:socialtinder/controller/user_controller.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:socialtinder/screens/homepage.dart';
import 'package:socialtinder/widgets/textfield.dart';


class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
     
       Loader loader  = Get.put(Loader());

    UserController userController  = Get.put(UserController());
//yar teri a list masla kar rhi
//kya ?
//yar a id deni lazmi c
// nh dety hta do 

  static List<Animal> _animals = [
    Animal(id: 1, name: "Jamaica"),
    Animal(id: 2, name: "Tukrs and calcos"),
    Animal(id: 3, name: "St.Linka"),
    Animal(id: 4, name: "Cuba"),
    Animal(id: 5, name: "Antigua and BarBuda"),
    Animal(id: 6, name: "US Virgin Island"),
    Animal(id: 7, name: "Aruba"),
    Animal(id: 8, name: "Dominican Republic"),
    Animal(id: 9, name: "Grenada"),
    Animal(id: 10, name: "The Bahamas"),
    Animal(id: 11, name: "St. Martin"),
    Animal(id: 12, name: "Puerto Rico"),
    Animal(id: 13, name: "Barbados"),
    Animal(id: 14, name: "Guadeloup"),
    Animal(id: 15, name: "Bermuda"),
    Animal(id: 16, name: "Cayman Islands"),
    Animal(id: 17, name: "British Virgin Islands"),
    Animal(id: 18, name: "Haiti"),
    Animal(id: 19, name: "St. Vincent and the Grenadines"),
    Animal(id: 20, name: "Montserrat"),
    Animal(id: 21, name: "St. Barts"),
    Animal(id: 22, name: "Trinidad and Tobago"),
    Animal(id: 23, name: "St. Kitts and Nevis"),
    Animal(id: 24, name: "Martinique"),
    Animal(id: 25, name: "Curacao"),
 
  ];
  //ya vala
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  // List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  bool _isSigningIn = false;

  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title:Text("SignUp",style:TextStyle(color: Color(0xFF111823))),

        backgroundColor: colorYellow,
      ),
    body: 
    GetBuilder<UserController>(builder: (_){
     return Container(
      decoration: BoxDecoration(
        image:DecorationImage(image: AssetImage("assets/palm.jpg"),fit: BoxFit.cover)
      ),
      height:Get.height,
      width:Get.width,
      child:Form(
        key: _.formKeySignUp,
           
              child: SingleChildScrollView(
                              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
 SizedBox(height: 15,),

     Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0),
                                child: 
                                textField(
                                  editingController: _.userNameController,
                                  hintText: "UserName",
                                 prefixicon:Icon(Icons.lock_outline,color: Colors.black,),
                                   textInputType:TextInputType.visiblePassword,
                                   
                                  validator: (input){
                                      
                              if (input.isEmpty) {
                                return 'Please Enter UserName';
                              } 
                         
                           
                   },

                                ),
                
               ),

           
        
        
        

   SizedBox(height: 15,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:48.0),
        child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                    // border: Border.all(
                    //   color: Theme.of(context).primaryColor,
                    //   width: 2,
                    // ),
                  ),
                  child: Column(
                    children: <Widget>[//ya h code
                      MultiSelectBottomSheetField(
                        initialChildSize: 0.4,
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonText: Text("Favorite Animals"),
                        title: Text("Animals"),
                        items: _items,
                        onConfirm: ( values) {
                          _.selectedAnimals2 = values;
                           userController.update();
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                                  
                                  _.selectedAnimals2.remove(value);
                                 userController.update();
                             
                              
                         
                          },
                        ),
                      ),
                      _.selectedAnimals2 == null || _.selectedAnimals2.isEmpty
                          ? Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "None selected",
                                style: TextStyle(color: Colors.black54),
                              ))
                          : Container(),
                    ],
                  ),
                ),
      ),
                SizedBox(height: 40),
               

               Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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

            GestureDetector(
              onTap: (){
                    final FormState formState =
                                  _.formKeySignUp.currentState;
                              if (formState.validate()) {
                                print('Form is validate');
                                     loader.loadingShow();
                                _.signUp();
                              } else {
                                print('Form is not Validate');
                              }
              },
                          child: Container(
               
                height: 50,width: 100,
                 color: colorDark,
                child: Center(child:Text("Sign Up",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),)),),
            )
    
        ],),
              ),
      )
    );
    }),
    
    

    );
  //  FlutterLogin(
  //     title: "Social Tinder",
  //     //logo: ,
  //     onLogin: (LoginData data) async {
  //       // await FirebaseService.signIn(data);

  //       return null;
  //     },
  //     onSubmitAnimationCompleted: () {
  //       print("login success");

  //       Navigator.of(context).pop();
  //     },
  //     onRecoverPassword: (String email) {
  //       return 
  //       // FirebaseService.recoverPassword(email);
        
  //       null;
  //     },
  //     onSignup: (LoginData data) async {
  //       // await FirebaseService.signUp(data)
  //       //     .then((value) => FirebaseService.addUser(value, data.name, null));

  //       // return null;
        
  //       return null;
  //     },
  //     messages: LoginMessages(
  //         usernameHint: "Email",
  //         passwordHint: "Password",
  //         confirmPasswordHint: "Confirm password",
  //         signupButton: "REGISTER",
  //         forgotPasswordButton: "Forgot Password?"),
  //     theme: LoginTheme(primaryColor: Colors.yellow, beforeHeroFontSize: 24),
  //   );
  }
}