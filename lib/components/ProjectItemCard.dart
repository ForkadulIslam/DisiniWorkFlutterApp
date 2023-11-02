import 'package:disiniwork/Models/ProjectDataModel.dart';
import 'package:disiniwork/components/SkillBadge.dart';
import 'package:flutter/material.dart';
class ProjectItemCard extends StatelessWidget {
  final ProjectDataModel project;
  ProjectItemCard({super.key, required this.project});

  @override
  @override
  Widget build(BuildContext context) {
    final List<String> skills = project.skills.split(',');
    print(skills.length);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  //color: Colors.redAccent
                ),
                width: double.infinity,
                child: Text(
                  project.title,
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Text(
                  'RM${project.price}',
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000),
                    height: 17/14,
                  ),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
          SizedBox(height: 15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(Icons.label_outline, color: Color(0xffff7519), size: 14,),
                    SizedBox(width: 5,),
                    Text('${project.projectType}', style: TextStyle(color: Color(0xff747474), fontSize: 12)),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.messenger_outline, color: Color(0xffff7519), size: 14),
                    SizedBox(width: 5,),
                    Text('No of proposal: ${project.noOfProposal}', style: TextStyle(color: Color(0xff747474), fontSize: 12)),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.watch_outlined, color: Color(0xffff7519), size: 14),
                    SizedBox(width: 5,),
                    Text('14 minutes ago', style: TextStyle(color: Color(0xff747474), fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text(
            '${project.description}',
            style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: 25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: skills.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: SkillBadge(skill: skills[index]),
                    );
                  },
                ),
              )
            ],
          ),
          Divider(
            thickness: 1,
            color: Color(0xffdddddd),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
