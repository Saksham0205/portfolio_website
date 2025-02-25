import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

class AchievementsSection extends StatelessWidget {
  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'IIIT Delhi 25 under 25 Winner',
      'description': 'Best startup idea under 25 among 100+ entries.',
      'icon': Icons.emoji_events,
    },
    {
      'title': 'Tech.Future Hackathon 2.0 Finalist',
      'description': 'Top 25 out of 500 teams at IIT Delhi.',
      'icon': Icons.code,
    },
    {
      'title': 'Pitch Your Idea Summit 2023 Winner',
      'description': 'Presented to 10+ investors at MAIT.',
      'icon': Icons.mic,
    },
    {
      'title': 'Survive.AI Winner',
      'description': 'Innovative concept to thrive in an AI-driven world.',
      'icon': Icons.psychology,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
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
                children: achievements.asMap().entries.map((entry) {
                  return AchievementCard(
                    achievement: entry.value,
                    width: constraints.maxWidth > 900
                        ? (constraints.maxWidth - 60) / 2
                        : constraints.maxWidth,
                  ).animate()
                      .fade(duration: 500.ms, delay: (entry.key * 200).ms)
                      .slideY(begin: 0.3, end: 0);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AchievementCard extends StatefulWidget {
  final Map<String, dynamic> achievement;
  final double width;

  AchievementCard({required this.achievement, required this.width});

  @override
  _AchievementCardState createState() => _AchievementCardState();
}

class _AchievementCardState extends State<AchievementCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: widget.width,
        child: GlassmorphicContainer(
          width: widget.width,
          height: 150,
          borderRadius: 20,
          blur: 10,
          border: 1,
          linearGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(isHovered ? 0.2 : 0.1),
              Colors.white.withOpacity(isHovered ? 0.1 : 0.05),
            ],
          ),
          borderGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.1),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    widget.achievement['icon'],
                    color: Colors.blue[300],
                    size: 30,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.achievement['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.achievement['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}