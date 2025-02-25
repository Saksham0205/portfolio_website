import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'Ajnabee - Salon Booking App',
      'description': 'Built a scalable salon booking app using Flutter and Firebase. Addressed user needs of 350 million women in India.',
      'link': 'https://play.google.com/store/apps/details?id=com.ajnabee.ajnabee&pcampaignid=web_share',
      'image': 'assets/ajnabee_preview.png',
      'technologies': ['Flutter', 'Firebase', 'Google Maps'],
    },
    {
      'title': 'Ajnabee Partner - Salon Management App',
      'description': 'Developed a Flutter app for salon partners, improving booking management by 40%.',
      'link': 'https://play.google.com/store/apps/details?id=com.ajnabeecorp.ajnabee_partner&pcampaignid=web_share',
      'image': 'assets/ajnabee_partner_preview.png',
      'technologies': ['Flutter', 'Firebase', 'Cloud Functions'],
    },
    {
      'title': 'Reswipe - Job Matching App',
      'description': 'Tinder-like job app with resume parsing; boosted user engagement by 50%.',
      'link': 'https://github.com/saksham0205/reswipe',
      'image': 'assets/ajnabee_preview.png',
      'technologies': ['Flutter', 'ML Kit', 'Node.js'],
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
            'Projects',
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
                children: projects.asMap().entries.map((entry) {
                  return ProjectCard(
                    project: entry.value,
                    width: constraints.maxWidth > 900
                        ? (constraints.maxWidth - 40) / 2
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

class ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final double width;

  ProjectCard({required this.project, required this.width});

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
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
          height: 400,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(
                  children: [
                    Image.asset(
                      widget.project['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if (isHovered)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black54,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                final url = Uri.parse(widget.project['link']);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              child: Text('View Project'),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.project['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 15),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (widget.project['technologies'] as List<String>)
                          .map((tech) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          tech,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[300],
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}