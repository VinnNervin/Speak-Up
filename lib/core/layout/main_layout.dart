import 'package:first_app/core/layout/placeholder_page.dart';
import 'package:first_app/core/widgets/HomepageNavgation/homepage_navigation.dart';
import 'package:first_app/features/adventure/pages/adventure_layout.dart';
import 'package:first_app/features/home/pages/home_page.dart';
// import 'package:first_app/core/widgets/HomepageHeader/home_header.dart';
import 'package:first_app/features/mission/pages/mission_page.dart';
import 'package:first_app/features/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const AdventureLayout(),
    const MissionPage(),
    const ProfilePage(),
    const PlaceholderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: HomeHeader(),
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: currentIndex, children: pages),
      ),
      bottomNavigationBar: HomepageNavigation(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
