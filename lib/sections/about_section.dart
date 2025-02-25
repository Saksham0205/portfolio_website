import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  void _downloadResume() async {
    // Replace with your actual resume URL
    final Uri url = Uri.parse('https://drive.google.com/file/d/1SbjF2OAVTh3d33EKhJdoTvXFY9xHJy1p/view?usp=sharing');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Stack(
        children: [
          // Animated background elements
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.blue.withOpacity(0.2), Colors.transparent],
                ),
              ),
            ).animate(
              onPlay: (controller) => controller.repeat(),
            ).scale(
              duration: 2000.ms,
              curve: Curves.easeInOut,
              begin: const Offset(1, 1),
              end: const Offset(1.2, 1.2),
            ).then().scale(
              duration: 2000.ms,
              curve: Curves.easeInOut,
              begin: const Offset(1.2, 1.2),
              end: const Offset(1, 1),
            ),
          ),

          // Main content
          Center(
            child: GlassmorphicContainer(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              borderRadius: 20,
              blur: 20,
              alignment: Alignment.center,
              border: 2,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ).animate()
                      .fade(duration: 500.ms)
                      .scale(duration: 500.ms),
                  SizedBox(height: 20),
                  Text(
                    'Saksham Chauhan',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate()
                      .fade(duration: 500.ms, delay: 200.ms)
                      .slideY(begin: 0.3, end: 0),
                  SizedBox(height: 10),
                  Text(
                    'Flutter Developer | Founder of Ajnabee',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue[300],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Passionate about building scalable mobile solutions and solving real-world problems. '
                          'With 2+ years of experience in Flutter development, I specialize in creating beautiful, '
                          'high-performance apps that users love.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ).animate()
                      .fade(duration: 500.ms, delay: 400.ms)
                      .slideY(begin: 0.3, end: 0),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _downloadResume,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download),
                        SizedBox(width: 8),
                        Text('Download Resume'),
                      ],
                    ),
                  ).animate()
                      .fade(duration: 500.ms, delay: 600.ms)
                      .slideY(begin: 0.3, end: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}