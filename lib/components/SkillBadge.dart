import 'package:flutter/material.dart';

class SkillBadge extends StatelessWidget {
  final String name;
  final Function onDelete;

  SkillBadge({required this.name, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xff747474)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontFamily: "Inter",
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}