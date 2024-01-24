import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../PhoneNumberVeryfy.dart';
import '../SplashPage.dart';
import '../UpdateProfilePage.dart';
class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset('lib/images/disini_work_logo.png',width: 150,)
                ),
                Align(
                  alignment: Alignment.centerRight,

                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            // Add functionality for icon2 here
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.notification_add_outlined),
                          onPressed: () {
                            // Add functionality for icon1 here
                          },
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: TextField(
                textAlignVertical: TextAlignVertical.center, // Center-align the text vertically
                decoration: InputDecoration(
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
            const SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Container(
                    width: 170,
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0), // Add horizontal spacing
                    child: const Card(
                      color: Color(0xff031a38),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Pending',style: TextStyle(fontSize: 18,color: Color(0xffffffff))),
                                Icon(Icons.speaker_notes_outlined,color: Color(0xfff05103),size: 30,),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '02 Days only for 1 projects',
                                    style: TextStyle(fontSize: 12, color: Color(0xffc3c9d0)),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 1.0), // Add horizontal spacing
                    child: const Card(
                      color: Color(0xff031a38),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Gigs',style: TextStyle(fontSize: 18,color: Color(0xffffffff))),
                                Icon(Icons.speaker_notes_outlined,color: Color(0xfff05103),size: 30,),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '01 New gigs received',
                                  style: TextStyle(fontSize: 12, color: Color(0xffc3c9d0)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0), // Add horizontal spacing
                    child: const Card(
                      color: Color(0xff031a38),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Pending',style: TextStyle(fontSize: 18,color: Color(0xffffffff))),
                                Icon(Icons.speaker_notes_outlined,color: Color(0xfff05103),size: 30,),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '02 Days only for 1 projects',
                                    style: TextStyle(fontSize: 12, color: Color(0xffc3c9d0)),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Services',style: TextStyle(fontSize: 20),),
                  Text('Show All',style: TextStyle(fontSize: 13, color: Color(0xffa5a4a4)),)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 70,
                      height: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfilePage()));
                              },
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.person,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),

                          Flexible(
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfilePage()));
                              },
                              child: Text(
                                'PROFILE',
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center, // Center-align the text
                              ),
                            )
                          ),
                        ],
                      )
                  ),
                  SizedBox(
                      width: 70,
                      height: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneNumberVerify()));
                              },
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.mobile_off_outlined,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),

                          Flexible(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfilePage()));
                                },
                                child: Text(
                                  'MOBILE VERYFY',
                                  style: TextStyle(fontSize: 11),
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center, // Center-align the text
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                  SizedBox(
                      width: 70,
                      height: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: InkWell(
                              onTap: () async {
                                // Get an instance of SharedPreferences
                                final prefs = await SharedPreferences.getInstance();
                                // Clear the stored values
                                prefs.remove('token');
                                prefs.remove('email');
                                prefs.remove('username');
                                prefs.remove('email_verified_at');

                                // You can also use prefs.clear() to remove all key-value pairs
                                 prefs.clear();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => SplashPage()),
                                );
                              },
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.logout,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),

                          Flexible(
                              child: InkWell(
                                onTap: () async{
                                  final prefs = await SharedPreferences.getInstance();
                                  // Clear the stored values
                                  prefs.remove('token');
                                  prefs.remove('email');
                                  prefs.remove('username');
                                  prefs.remove('email_verified_at');

                                  // You can also use prefs.clear() to remove all key-value pairs
                                  prefs.clear();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => SplashPage()),
                                  );
                                },
                                child: Text(
                                  'LOGOUT',
                                  style: TextStyle(fontSize: 11),
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center, // Center-align the text
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                  // SizedBox(
                  //     width: 70,
                  //     height: 120,
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         SizedBox(
                  //           width: 70,
                  //           height: 70,
                  //           child: InkWell(
                  //             onTap: (){
                  //               Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfilePage()));
                  //             },
                  //             child: Card(
                  //                 color: Color(0xffffffff),
                  //                 elevation: 4.0,
                  //                 child: Align(
                  //                   alignment: Alignment.center,
                  //                   child: Icon(Icons.settings,color: Color(0xfff9671e),size: 40,),
                  //                 )
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(height: 5,),
                  //         Flexible(
                  //           child: Text(
                  //             'Programming & Development',
                  //             style: TextStyle(fontSize: 11),
                  //             softWrap: true,
                  //             maxLines: 2,
                  //             overflow: TextOverflow.fade,
                  //             textAlign: TextAlign.center, // Center-align the text
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  // ),
                  // SizedBox(
                  //     width: 70,
                  //     height: 120,
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         SizedBox(
                  //           width: 70,
                  //           height: 70,
                  //           child: Card(
                  //               color: Color(0xffffffff),
                  //               elevation: 4.0,
                  //               child: Align(
                  //                 alignment: Alignment.center,
                  //                 child: Icon(Icons.book_outlined,color: Color(0xfff9671e),size: 40,),
                  //               )
                  //           ),
                  //         ),
                  //         SizedBox(height: 5,),
                  //         Flexible(
                  //           child: Text(
                  //             'Content creation & writing',
                  //             style: TextStyle(fontSize: 11),
                  //             softWrap: true,
                  //             maxLines: 2,
                  //             overflow: TextOverflow.fade,
                  //             textAlign: TextAlign.center, // Center-align the text
                  //             textScaleFactor: 1.0, // Prevent text from scaling
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  // ),
                  // SizedBox(
                  //     width: 70,
                  //     height: 120,
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         SizedBox(
                  //           width: 70,
                  //           height: 70,
                  //           child: Card(
                  //               color: Color(0xffffffff),
                  //               elevation: 4.0,
                  //               child: Align(
                  //                 alignment: Alignment.center,
                  //                 child: Icon(Icons.campaign_outlined,color: Color(0xfff9671e),size: 40,),
                  //               )
                  //           ),
                  //         ),
                  //         SizedBox(height: 5,),
                  //         Flexible(
                  //           child: Text(
                  //             'Digital marketing',
                  //             style: TextStyle(fontSize: 11),
                  //             softWrap: true,
                  //             maxLines: 2,
                  //             overflow: TextOverflow.fade,
                  //             textAlign: TextAlign.center, // Center-align the text
                  //             textScaleFactor: 1.0, // Prevent text from scaling
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  // ),

                ],
              ),
            ),
            const SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}
