// ignore_for_file: prefer_const_constructors

import 'package:disiniwork/pages/UpdateProfilePage.dart';
import 'package:disiniwork/pages/navigationbar_content/ProjectDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ColorSupport.dart';

class ProfileNavContent extends StatefulWidget {
  const ProfileNavContent({super.key});

  @override
  State<ProfileNavContent> createState() => _ProfileNavContentState();

}
class _ProfileNavContentState extends State<ProfileNavContent> {

  Widget _buildListItem(String text, IconData icon,Function() onTap) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),

        child: ListTile(
          leading: Icon(icon, size: 20,color: Color(0xffff7519),),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.3,
              decoration: BoxDecoration(
                  color: Color(0xff031A38),
              ),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xffdfdfdfdf), // Add a border color if needed
                            width: 1.0, // Border width
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://api.disiniwork.com/uploads/profiles/avatar.jpg',
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text('Error loading image'),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Kelly Clarkson",
                            style:TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffffffff),
                              height: 15/12,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "Online",
                            style:TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffffffff),
                              height: 15/12,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 15,)
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 20, // Adjust the top position as needed
                    right: 0, // Adjust the right position as needed
                    child: Container(
                      width: 30, // Adjust the width of the container as needed
                      height: 30, // Adjust the height of the container as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white12, // Border color
                          width: 5.0, // Border width
                        ),
                      ),
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                        size: 15, // Adjust the size of the camera icon as needed
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            _buildListItem("Profile", Icons.person,(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfilePage()));
            }),
            // _buildListItem("Settings", Icons.settings, (){
            //
            // }),
            // _buildListItem("Verification", Icons.verified_user, (){
            //
            // }),
            // _buildListItem("Payment", Icons.payment, (){
            //
            // }),
            // _buildListItem("Withdrawal", Icons.money, () async{
            //
            // }),

          ],
        ),
      ),
    );
  }
}
