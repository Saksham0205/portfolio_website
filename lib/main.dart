import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/achievements_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saksham Chauhan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background particles
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A0E21),
                  Color(0xFF1A1B4B),
                ],
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                AboutSection(),
                SkillsSection(),
                ProjectsSection(),
                AchievementsSection(),
                ContactSection(),
              ],
            ),
          ),
          // Floating navigation button
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                );
              },
              child: Icon(Icons.arrow_upward),
              backgroundColor: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }
}