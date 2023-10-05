
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double cardWidth = 200;
    return Scaffold(
      backgroundColor: Color(0xfffefeff),
      bottomNavigationBar: BottomNavigationBar(
        //selectedFontSize: 20,
        selectedItemColor: Color(0xfff85909),
        //unselectedFontSize: 20,
        //unselectedItemColor: Color(0xfff85909),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add_home_outlined,color: Color(0xfff85909),size: 40,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined, color: Color(0xff303030), size: 40,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined, color: Color(0xff303030), size: 40,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.file_copy_outlined, color: Color(0xff303030), size: 40,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, color: Color(0xff303030), size: 40,), label: ''),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset('lib/images/disini_work_logo.png',width: 150,)
                  ),
                  Align(
                    alignment: Alignment.centerRight,

                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              // Add functionality for icon2 here
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.notification_add_outlined),
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
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center, // Center-align the text vertically
                  decoration: InputDecoration(
                    filled: true, // Set to true to enable background color
                    fillColor: Color(0xfff0f1f5),
                    prefixIcon: Icon(Icons.search), // Search icon on the left
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff0f1f5)), // Border color when focused
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),

                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Container(
                      width: 170,
                      height: 90,
                      margin: EdgeInsets.symmetric(horizontal: 2.0), // Add horizontal spacing
                      child: Card(
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
                                  Text(
                                    '02 Days only for 1 projects',
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
                      margin: EdgeInsets.symmetric(horizontal: 1.0), // Add horizontal spacing
                      child: Card(
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
                      margin: EdgeInsets.symmetric(horizontal: 2.0), // Add horizontal spacing
                      child: Card(
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
                                  Text(
                                    '02 Days only for 1 projects',
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
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
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
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                      height: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Card(
                                color: Color(0xffffffff),
                                elevation: 4.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.brush_outlined,color: Color(0xfff9671e),size: 40,),
                                )
                            ),
                          ),
                          SizedBox(height: 5,),
                          ClipRect(
                            child: Text(
                              'Design and creative art',
                              style: TextStyle(fontSize: 11),
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center, // Center-align the text
                              textScaleFactor: 1.0, // Prevent text from scaling
                            ),
                          ),
                        ],
                      )
                    ),
                    Container(
                      width: 70,
                      height: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Card(
                                color: Color(0xffffffff),
                                elevation: 4.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.code_outlined,color: Color(0xfff9671e),size: 40,),
                                )
                            ),
                          ),
                          SizedBox(height: 5,),
                          ClipRect(
                            child: Text(
                              'Programming & Development',
                              style: TextStyle(fontSize: 11),
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center, // Center-align the text
                              textScaleFactor: 1.0, // Prevent text from scaling
                            ),
                          ),
                        ],
                      )
                    ),
                    Container(
                      width: 70,
                      height: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Card(
                                color: Color(0xffffffff),
                                elevation: 4.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.book_outlined,color: Color(0xfff9671e),size: 40,),
                                )
                            ),
                          ),
                          SizedBox(height: 5,),
                          ClipRect(
                            child: Text(
                              'Content creation & writing',
                              style: TextStyle(fontSize: 11),
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center, // Center-align the text
                              textScaleFactor: 1.0, // Prevent text from scaling
                            ),
                          ),
                        ],
                      )
                    ),
                    Container(
                      width: 70,
                      height: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Card(
                                color: Color(0xffffffff),
                                elevation: 4.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.campaign_outlined,color: Color(0xfff9671e),size: 40,),
                                )
                            ),
                          ),
                          SizedBox(height: 5,),
                          ClipRect(
                            child: Text(
                              'Digital marketing',
                              style: TextStyle(fontSize: 11),
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center, // Center-align the text
                              textScaleFactor: 1.0, // Prevent text from scaling
                            ),
                          ),
                        ],
                      )
                    ),

                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 70,
                        height: 120,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.translate_outlined,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            ClipRect(
                              child: Text(
                                'Translate & Language',
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center, // Center-align the text
                                textScaleFactor: 1.0, // Prevent text from scaling
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: 70,
                        height: 120,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.assistant,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            ClipRect(
                              child: Text(
                                'Virtual Assistant',
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center, // Center-align the text
                                textScaleFactor: 1.0, // Prevent text from scaling
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: 70,
                        height: 120,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.perm_media_outlined,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            ClipRect(
                              child: Text(
                                'Video & Audio',
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center, // Center-align the text
                                textScaleFactor: 1.0, // Prevent text from scaling
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: 70,
                        height: 120,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.cast_for_education_outlined,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            ClipRect(
                              child: Text(
                                'Education & Training',
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center, // Center-align the text
                                textScaleFactor: 1.0, // Prevent text from scaling
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 70,
                        height: 120,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.health_and_safety_outlined,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            ClipRect(
                              child: Text(
                                'Health & Wellness',
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center, // Center-align the text
                                textScaleFactor: 1.0, // Prevent text from scaling
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: 70,
                        height: 120,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.point_of_sale_outlined,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            ClipRect(
                              child: Text(
                                'Sales & Marketing',
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center, // Center-align the text
                                textScaleFactor: 1.0, // Prevent text from scaling
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: 70,
                        height: 120,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.event_note_outlined,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            ClipRect(
                              child: Text(
                                'Event & Cordination',
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center, // Center-align the text
                                textScaleFactor: 1.0, // Prevent text from scaling
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: 70,
                        height: 120,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                  color: Color(0xffffffff),
                                  elevation: 4.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.low_priority_outlined,color: Color(0xfff9671e),size: 40,),
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            ClipRect(
                              child: Text(
                                'Legal & Financial',
                                style: TextStyle(fontSize: 11),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center, // Center-align the text
                                textScaleFactor: 1.0, // Prevent text from scaling
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      )
    );
  }
}
