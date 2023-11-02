import 'package:flutter/material.dart';
class SkillBadge extends StatelessWidget {
  final String skill;
  const SkillBadge({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff747474)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          fontFamily: "Inter",
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color(0xff747474),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
