import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{

  final VoidCallback onPressed;
  final String btnText;

  const CustomButton({super.key, required this.onPressed, required this.btnText});

  @override
  Widget build (BuildContext context){
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xff031a38),
            borderRadius:BorderRadius.circular(8)
        ),
        child: TextButton.icon(
          onPressed: onPressed,
          icon: Icon(Icons.login),
          label: Text(
            btnText,
            style: TextStyle(
                color: Color(0xfffefeff),
                fontSize: 15
            ),
          ),
          style: TextButton.styleFrom(

          ),
        )
    );
  }
}