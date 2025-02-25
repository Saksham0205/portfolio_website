import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

class SkillsSection extends StatelessWidget {
  final List<Map<String, dynamic>> skills = [
    {'name': 'Flutter', 'level': 0.9},
    {'name': 'Dart', 'level': 0.85},
    {'name': 'Firebase', 'level': 0.8},
    {'name': 'Node.js', 'level': 0.75},
    {'name': 'Python', 'level': 0.7},
    {'name': 'Java', 'level': 0.65},
    {'name': 'C++', 'level': 0.6},
    {'name': 'Git', 'level': 0.85},
    {'name': 'Docker', 'level': 0.7},
    {'name': 'MongoDB', 'level': 0.75},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate()
              .fade(duration: 500.ms)
              .slideX(begin: -0.3, end: 0),
          SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: skills.map((skill) {
                  return GlassmorphicContainer(
                    width: constraints.maxWidth > 600
                        ? (constraints.maxWidth - 60) / 3
                        : constraints.maxWidth,
                    height: 80,  // Reduced height since we removed percentage text
                    borderRadius: 20,
                    blur: 10,
                    border: 1,
                    linearGradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                    ),
                    borderGradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skill['name'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15),
                          TweenAnimationBuilder(
                            duration: Duration(milliseconds: 1500),
                            tween: Tween<double>(begin: 0, end: skill['level']),
                            builder: (context, double value, child) {
                              return LinearProgressIndicator(
                                value: value,
                                backgroundColor: Colors.blue.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue[400]!,
                                ),
                                minHeight: 6,  // Slightly thicker progress bar for better visibility
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ).animate()
                      .fade(duration: 500.ms)
                      .scale(delay: 200.ms);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}