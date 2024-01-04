import 'package:flutter/material.dart';

import '../../constants.dart';
class MyProjectContent extends StatefulWidget {
  const MyProjectContent({super.key});

  @override
  State<MyProjectContent> createState() => _MyProjectContentState();
}

class _MyProjectContentState extends State<MyProjectContent> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text('Welcome..')
    );
  }



}
