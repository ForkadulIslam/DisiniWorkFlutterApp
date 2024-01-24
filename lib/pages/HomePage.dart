
import 'package:disiniwork/pages/navigationbar_content/BrowsProjectContent.dart';
import 'package:disiniwork/pages/navigationbar_content/DashboardContent.dart';
import 'package:disiniwork/pages/navigationbar_content/ProfileNavContent.dart';
import 'package:flutter/material.dart';

import 'navigationbar_content/MyProjectContent.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  // Create a list of pages
  final List<Widget> _pages = [
    const DashboardContent(), // Replace with your actual pages
    const DashboardContent(),
    const BrowseProjectContent(),
    const MyProjectContent(),
    const ProfileNavContent(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300), // Adjust the animation duration as needed
        curve: Curves.fastLinearToSlowEaseIn, // Adjust the animation curve as needed
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = 200;
    return Scaffold(
      backgroundColor: const Color(0xfffefeff),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xfff85909),
        unselectedItemColor: const Color(0xff303030),
        currentIndex: _selectedIndex, // Set the selected index
        onTap: _onItemTapped, // Handle tap events
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_home_outlined,size: 40,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined, size: 40,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined, size: 40,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.file_copy_outlined, size: 40,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 40,), label: ''),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      )
    );
  }
}
