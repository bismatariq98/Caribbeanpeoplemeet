import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialtinder/const/color.dart';
import 'package:socialtinder/controller/restaurant_controller.dart';
import 'package:socialtinder/screens/homepage.dart';
import 'package:socialtinder/widgets/textfield.dart';


class AddRestaurant extends StatefulWidget {
  @override
  _AddRestaurantState createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  Restaurant restaurant = Get.put(Restaurant());
  
  @override
  Widget build(BuildContext context) {
    return 

     Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0.0,
        leading: Container(),
          
        actions: [
          IconButton(icon: Icon(Icons.cancel), onPressed: (){
            Get.to(HomePage());
          })
        ],
      ),
      body:  
      
      
       GetBuilder<Restaurant>(builder: (_){
         return   Container(height: Get.height,width: Get.width,
      child: SingleChildScrollView(
              child: Column(children:[
          Container(height: Get.height/2 -250,width: Get.width,color: Colors.pink,
          child:
         Padding(
           padding: const EdgeInsets.symmetric(horizontal:18.0),
           child: Text("Enter Details To Add Restaurant Info",style: headingTextWhite,),
         ),

          ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal:19.0),
             child: Column(
               children: [
                 SizedBox(height: 10,),
                           textField(
                                          editingController: _.restaurantNameController,
                                          hintText: "Restaurant Name",
                                         prefixicon:Icon(Icons.email,color: Colors.black,),
                                           textInputType:TextInputType.name,
                                          validator: (input){
                             
                                      
                         },

                                        ),
                 SizedBox(height: 10,),
                                  textField(
                                          editingController: _.contactInfoController,
                                          hintText: "ContactInfo",
                                         prefixicon:Icon(Icons.email,color: Colors.black,),
                                           textInputType:TextInputType.number,
                                          validator: (input){
                             
                                    
                         },

                                        ),
                 SizedBox(height: 10,),
                              textField(
                                          editingController: _.addressController,
                                          hintText: "Address",
                                         prefixicon:Icon(Icons.email,color: Colors.black,),
                                           textInputType:TextInputType.streetAddress,
                                          validator: (input){
                             
                                      
                         },

                                        ),
                
                  SizedBox(height: 10,),
               
                 

               ],
             ),
           ),

           Container(height: Get.height/2 -300,width: Get.width/2,color: Colors.pink,
          child: GestureDetector(
            onTap:() async{
               
              // await restaurantController.addClinic();

            },
            child: 
            Center(child: 
            
            Text("Send For Approval",style: normalTextWhite ),)),
          ),
        ]),
      ),
      
      );
     
       })
      
      
     
      
    );
  }
}