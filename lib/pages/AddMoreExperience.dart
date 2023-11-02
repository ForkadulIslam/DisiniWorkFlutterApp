import 'package:flutter/material.dart';
class AddMoreExperience extends StatefulWidget {
  const AddMoreExperience({super.key});

  @override
  State<AddMoreExperience> createState() => _AddMoreExperienceState();
}

class _AddMoreExperienceState extends State<AddMoreExperience> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff031A38),
        title: Text('Add Experience',style: TextStyle(fontSize: 13),),
      ),
    );
  }
}
