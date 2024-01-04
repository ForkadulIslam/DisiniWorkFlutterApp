import 'package:disiniwork/pages/navigationbar_content/ProjectDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ProjectDataModel.dart';
import '../../components/ProjectItemCard.dart';
import '../../constants.dart';
class MyProjectContent extends StatefulWidget {
  const MyProjectContent({super.key});

  @override
  State<MyProjectContent> createState() => _MyProjectContentState();
}

class _MyProjectContentState extends State<MyProjectContent> {

  List<ProjectDataModel> projects = [];
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async{
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    String token = pref.getString('token').toString();
                    String slug = projects[index].slug;
                    String url = 'https://disiniwork.com/jobs/$slug?appkey=${token}';
                    //print(url);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectDetails(url: url)));
                  },
                  child: ProjectItemCard(project: projects[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }



}
