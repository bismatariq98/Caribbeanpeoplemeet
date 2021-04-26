import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Widget textField({validator,hintText,Icon prefixicon,TextInputType textInputType,TextEditingController editingController}) {
   return TextFormField(
     controller: editingController,
                   cursorColor: Colors.black,
                 
                    keyboardType: textInputType,
                 decoration: InputDecoration(
                   filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.black,width:2.0),
                    borderRadius:BorderRadius.circular(15)
                  ),
                  border: OutlineInputBorder(
                    
                    borderRadius:BorderRadius.circular(12),
                    borderSide:BorderSide(color: Colors.black)
                  ),
              
                   hintText: hintText,
                   contentPadding: EdgeInsets.all(5.0),
                   prefixIcon: prefixicon,
                   fillColor:Colors.white,
                  
                 ),

                 );

}