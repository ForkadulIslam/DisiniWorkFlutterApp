import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String hintText, IconData icon){
  return InputDecoration(
    //hintText: hintText,
    hintStyle: TextStyle(
        color: Color(0xffff7519)
    ),
    prefixIcon: Icon(icon, color: Color(0xffff7519),size: 13,),
    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    labelText: hintText,
    labelStyle: TextStyle(
        fontSize: 13,
        color: Color(0xffa9a9a9)
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Color(0xffff7519))
    ),

  );
}