import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{

  final Function? onTap;
  final String btnText;

  const CustomButton({super.key, required this.onTap, required this.btnText});

  @override
  Widget build (BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      //margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xff031a38),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(
        child: Text(btnText,style: TextStyle(
            color: Color(0xfffefeff),
            fontSize: 20
        ),),
      ),
    );
  }
}