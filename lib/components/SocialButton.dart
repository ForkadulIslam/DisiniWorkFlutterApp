import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget{

  final Function? onTap;
  final String btnText;
  final String path;

  const SocialButton({super.key, required this.btnText, required this.path,  required this.onTap});

  @override
  Widget build (BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      //margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xffe7e7e8),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              this.path,
              height: 30,
            ),
            SizedBox(width: 20,),
            Text(this.btnText,style: TextStyle(
              color: Color(0xff0f0f10),
              fontSize: 17
            ),)
          ],
        ),
      ),
    );
  }
}