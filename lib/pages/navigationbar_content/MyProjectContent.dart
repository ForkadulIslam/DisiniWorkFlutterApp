import 'dart:convert';

import 'package:disiniwork/Models/MyProjectDataModel.dart';
import 'package:disiniwork/components/MyProjectItemCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Models/ProjectDataModel.dart';
import '../../components/ProjectItemCard.dart';
import '../../constants.dart';
import 'ProjectDetails.dart';

class MyProjectContent extends StatefulWidget {
  const MyProjectContent({super.key});

  @override
  State<MyProjectContent> createState() => _MyProjectContentState();
}

class _MyProjectContentState extends State<MyProjectContent>
    with SingleTickerProviderStateMixin {
  List<MyProjectDataModel> completedProjects = [];
  List<MyProjectDataModel> inProgressProjects = [];
  bool loading = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getMyProject();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Align(
            child: Text(
              textAlign:TextAlign.center,
              'My Work History',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10,),
          TabBar(
            indicatorColor: Color(0xffff7519),
            controller: _tabController,
            tabs: [
              Tab(text: 'Completed Projects'),
              Tab(text: 'In-Progress Projects'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: loading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff031a38)),
                            // Change this to your desired color
                            strokeWidth: 2,
                          ),
                        )
                      : buildProjectsList(completedProjects),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xff031a38)),
                          // Change this to your desired color
                          strokeWidth: 2,
                        ),
                      )
                    : buildProjectsList(inProgressProjects)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProjectsList(List<MyProjectDataModel> projects) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            String token = pref.getString('token').toString();
            String slug = projects[index].slug;
            String url =
                'https://disiniwork.com/jobs/$slug?appkey=${token}';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectDetails(url: url),
              ),
            );
          },
          child: MyProjectItemCard(project: projects[index]),
        );
      },
    );
  }

  getMyProject() async {
    setState(() {
      loading = true;
    });
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token').toString();
      final Uri url = Uri.parse('$apiBaseUrl/getmyprojects');
      print(url);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        for (var projectData in responseData['data']) {
          List<String> skillsNames = [];
          for (var skill in projectData['skills']) {
            if (skill is Map<String, dynamic> && skill['name'] is String) {
              skillsNames.add(skill['name']);
            }
          }
          projectData['skills'] = skillsNames.join(',');
          final MyProjectDataModel project = MyProjectDataModel.fromJson(projectData);
          if (project.status == 'COMPLETED') {
            completedProjects.add(project);
          } else {
            inProgressProjects.add(project);
          }
        }
        if(response.statusCode == 401){
          print('Token expired');
        }

        setState(() {
          loading = false;
        });
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      print('Errors: ${error}');
    }
  }
}
