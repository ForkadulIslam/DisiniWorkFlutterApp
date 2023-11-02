import 'package:disiniwork/Models/ProjectDataModel.dart';
import 'package:disiniwork/components/ProjectItemCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrowseProjectContent extends StatefulWidget {
  const BrowseProjectContent({super.key});

  @override
  State<BrowseProjectContent> createState() => _BrowseProjectContentState();
}

class _BrowseProjectContentState extends State<BrowseProjectContent> {
  final List<ProjectDataModel> projects = [
    ProjectDataModel(
      title: 'Web development',
      description: 'Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami ',
      projectType:'Fixed',
      noOfProposal: 9,
      price: 1300,
      skills: 'HTML, CSS, JQUERY',
      publishedAt: '2023-10-30',
    ),
    ProjectDataModel(
      title: 'Mobile APP development - Flutter',
      description: 'Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami ',
      projectType:'Fixed',
      noOfProposal: 5,
      price: 1200,
      skills: 'PHO, Laravel, NodeJs',
      publishedAt: '2023-10-30',
    ),
    ProjectDataModel(
      title: 'Full-Stack Developer - Laravel',
      description: 'Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami ',
      projectType:'Fixed',
      noOfProposal: 69,
      price: 2000,
      skills: 'Vuejs, ReactJs, HTML, CSS',
      publishedAt: '2023-10-30',
    ),
    ProjectDataModel(
      title: 'NestJs Developer',
      description: 'Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami Lorium spun doller sit ami ',
      projectType:'Fixed',
      noOfProposal: 12,
      price: 300,
      skills: 'PHP, Laravel, NestJs',
      publishedAt: '2023-10-30',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Align(
            child: Text(
              textAlign:TextAlign.center,
              'Browse Project',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center, // Center-align the text vertically
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                filled: true, // Set to true to enable background color
                fillColor: const Color(0xfff0f1f5),
                prefixIcon: const Icon(Icons.search), // Search icon on the left
                hintText: 'Search...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xfff0f1f5)), // Border color when focused
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),

            ),
          ),
          const SizedBox(height: 30,),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectItemCard(project: projects[index]);
              },
            ),
          )

        ],
      ),
    );
  }
}
