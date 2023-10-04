import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget{

  final VoidCallback onPressed;
  final String btnText;
  final String path;

  const SocialButton({super.key, required this.btnText, required this.path,  required this.onPressed});

  @override
  Widget build (BuildContext context){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffe7e7e8),
        borderRadius:BorderRadius.circular(8)
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          this.path,
          height: 35,
        ),
        label: Text(
            btnText,
            style: TextStyle(
              color: Color(0xff666666),
              fontSize: 17
            ),
        ),
        style: TextButton.styleFrom(
            // shape: RoundedRectangleBorder(
            //     side: BorderSide(
            //         color: Color(0xffe7e7e8),
            //         width: 2
            //     )
            // )
        ),
      )
    );
  }
}