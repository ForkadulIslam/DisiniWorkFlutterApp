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
            color: const Color(0xffff7519),
            borderRadius:BorderRadius.circular(8)
        ),
        child: TextButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.login, color: Color(0xff031a38),weight: 900,),
          label: Text(
            btnText,
            style: const TextStyle(
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