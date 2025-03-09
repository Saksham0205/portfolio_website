import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:lottie/lottie.dart';

const String MOBILE = 'MOBILE';
const String TABLET = 'TABLET';
const String DESKTOP = 'DESKTOP';
const String XL = 'XL';

void main() {
  runApp(PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saksham | Flutter Developer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A192F),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentNavIndex = 0;
  final List<String> _navItems = ['Home', 'Skills', 'Projects', 'Achievements', 'Contact'];
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateNavOnScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateNavOnScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateNavOnScroll() {
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final RenderBox? renderBox = _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        if (position.dy <= 100) {
          if (_currentNavIndex != i) {
            setState(() => _currentNavIndex = i);
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final RenderBox renderBox = _sectionKeys[index].currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    _scrollController.animateTo(
      _scrollController.offset + position.dy - 80,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() => _currentNavIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A192F).withOpacity(0.9),
        elevation: 0,
        title: Text(
          'SAKSHAM',
          style: TextStyle(
            color: Color(0xFF64FFDA),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: isMobile
            ? [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Color(0xFF172A45),
                builder: (context) => _buildMobileMenu(),
              );
            },
          )
        ]
            : _navItems
            .asMap()
            .entries
            .map(
              (entry) => TextButton(
            onPressed: () => _scrollToSection(entry.key),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                entry.value,
                style: TextStyle(
                  color: _currentNavIndex == entry.key ? Color(0xFF64FFDA) : Colors.white,
                ),
              ),
            ),
          ),
        )
            .toList(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroSection(key: _sectionKeys[0]),
            _buildSkillsSection(key: _sectionKeys[1]),
            _buildProjectsSection(key: _sectionKeys[2]),
            _buildAchievementsSection(key: _sectionKeys[3]),
            _buildContactSection(key: _sectionKeys[4]),
            _buildFooter(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF64FFDA),
        child: Icon(Icons.arrow_upward, color: Color(0xFF0A192F)),
        onPressed: () => _scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  Widget _buildMobileMenu() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _navItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            _navItems[index],
            style: TextStyle(
              color: _currentNavIndex == index ? Color(0xFF64FFDA) : Colors.white,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            _scrollToSection(index);
          },
        );
      },
    );
  }

  Widget _buildHeroSection({Key? key}) {
    return Container(
      key: key,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: ResponsiveRowColumn(
        rowMainAxisAlignment: MainAxisAlignment.center,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        columnMainAxisAlignment: MainAxisAlignment.center,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        layout: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hello, I'm",
                  style: TextStyle(
                    color: Color(0xFF64FFDA),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ).animate().fadeIn(duration: 800.ms).slideX(),
                SizedBox(height: 10),
                Text(
                  "Saksham",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ).animate().fadeIn(duration: 800.ms, delay: 300.ms).slideX(),
                SizedBox(height: 10),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flutter Enthusiast',
                      textStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'Startup Founder',
                      textStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'Clean Code Advocate',
                      textStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'AI Innovator',
                      textStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                  repeatForever: true,
                ),
                SizedBox(height: 30),
                Text(
                  "Building scalable mobile solutions | Building @Ajnabee",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => _scrollToSection(4),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Color(0xFF64FFDA)),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    "Get In Touch",
                    style: TextStyle(
                      color: Color(0xFF64FFDA),
                    ),
                  ),
                ).animate().fadeIn(duration: 800.ms, delay: 900.ms).slideY(),
              ],
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Center(
              child: Image.asset(
                'assets/profile.jpg',
                height: 400,
              ),
            ).animate().fadeIn(duration: 1000.ms, delay: 600.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection({Key? key}) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Technical Arsenal",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Divider(
                  color: Color(0xFF64FFDA).withOpacity(0.5),
                  thickness: 1,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 800.ms).slideX(),
          SizedBox(height: 40),
          ResponsiveRowColumn(
            rowSpacing: 30,
            columnSpacing: 30,
            layout: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _buildSkillCategory(
                  title: "Mobile Development",
                  skills: [
                    SkillItem(name: "Flutter", iconData: Icons.flutter_dash, color: Color(0xFF02569B)),
                    SkillItem(name: "Dart", iconData: Icons.code, color: Color(0xFF0175C2)),
                    SkillItem(name: "Firebase", iconData: Icons.local_fire_department, color: Color(0xFFFFCA28)),
                  ],
                ),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _buildSkillCategory(
                  title: "Backend & DevOps",
                  skills: [
                    SkillItem(name: "Node.js", iconData: FontAwesomeIcons.nodeJs, color: Color(0xFF43853D)),
                    SkillItem(name: "Postman", iconData: Icons.send, color: Color(0xFFFF6C37)),
                    SkillItem(name: "Docker", iconData: FontAwesomeIcons.docker, color: Color(0xFF2496ED)),
                    SkillItem(name: "MongoDB", iconData: Icons.storage, color: Color(0xFF47A248)),
                  ],
                ),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _buildSkillCategory(
                  title: "Languages",
                  skills: [
                    SkillItem(name: "Python", iconData: FontAwesomeIcons.python, color: Color(0xFF3776AB)),
                    SkillItem(name: "Java", iconData: FontAwesomeIcons.java, color: Color(0xFFED8B00)),
                    SkillItem(name: "C++", iconData: Icons.code, color: Color(0xFF00599C)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory({required String title, required List<SkillItem> skills}) {
    return Card(
      elevation: 10,
      color: Color(0xFF172A45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF64FFDA),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            ...skills.map((skill) => _buildSkillItem(skill)).toList(),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).scale(delay: 200.ms);
  }

  Widget _buildSkillItem(SkillItem skill) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: skill.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              skill.iconData,
              color: skill.color,
              size: 20,
            ),
          ),
          SizedBox(width: 15),
          Text(
            skill.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection({Key? key}) {
    final List<ProjectItem> projects = [
      ProjectItem(
        title: "Ajnabee - Salon Booking App",
        description: "Addressed user needs of 350 million women in India by providing easy access to salon services. Implemented state management using Bloc/Provider for scalability. Managed a cross-functional team of 10.",
        technologies: ["Flutter", "Firebase", "UPI Payment Gateway"],
        url: "https://play.google.com/store/apps/details?id=com.ajnabee.ajnabee&pcampaignid=web_share",
        color: Color(0xFFE91E63),
      ),
      ProjectItem(
        title: "Reswipe - Job Matching App",
        description: "Tinder-like job app with resume parsing; boosted user engagement by 50%. Features: resume parsing, swipe-to-apply, real-time application tracking.",
        technologies: ["Flutter", "Firebase", "Machine Learning"],
        url: "https://github.com/saksham0205/reswipe",
        color: Color(0xFF2196F3),
      ),
      ProjectItem(
        title: "Ajnabee Partner - Salon Management App",
        description: "Improved booking management by 40% for salon partners. Integrated secure payment gateway with robust security measures.",
        technologies: ["Flutter", "Firebase", "RESTful APIs"],
        url: "https://play.google.com/store/apps/details?id=com.ajnabeecorp.ajnabee_partner&pcampaignid=web_share",
        color: Color(0xFF4CAF50),
      ),
    ];

    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Highlight Projects",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Divider(
                  color: Color(0xFF64FFDA).withOpacity(0.5),
                  thickness: 1,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 800.ms).slideX(),
          SizedBox(height: 40),
          ResponsiveRowColumn(
            rowSpacing: 30,
            columnSpacing: 30,
            layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: projects
                .asMap()
                .entries
                .map(
                  (entry) => ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _buildProjectCard(entry.value, delay: entry.key * 200),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(ProjectItem project, {int delay = 0}) {
    return Card(
      elevation: 10,
      color: Color(0xFF172A45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 380,
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.folder_open,
                  color: project.color,
                  size: 40,
                ),
                IconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final Uri url = Uri.parse(project.url);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              project.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Text(
                project.description,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies
                  .map(
                    (tech) => Chip(
                  label: Text(
                    tech,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: project.color.withOpacity(0.2),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: delay.ms).scale(delay: 200.ms + delay.ms);
  }

  Widget _buildAchievementsSection({Key? key}) {
    final List<AchievementItem> achievements = [
      AchievementItem(
        title: "IIIT Delhi 25 under 25 Winner",
        description: "Best startup idea under 25 among 100+ entries",
        icon: Icons.emoji_events,
      ),
      AchievementItem(
        title: "Tech.Future Hackathon 2.0 Finalist",
        description: "Top 25 out of 500 teams at IIT Delhi",
        icon: Icons.code,
      ),
      AchievementItem(
        title: "Pitch Your Idea Summit 2023 Winner",
        description: "Presented to 10+ investors at MAIT",
        icon: Icons.trending_up,
      ),
      AchievementItem(
        title: "Survive.AI Winner",
        description: "Innovative concept to thrive in an AI-driven world, competing against 100+ teams",
        icon: Icons.smart_toy,
      ),
    ];

    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Achievements",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Divider(
                  color: Color(0xFF64FFDA).withOpacity(0.5),
                  thickness: 1,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 800.ms).slideX(),
          SizedBox(height: 40),
          ...achievements
              .asMap()
              .entries
              .map(
                (entry) => _buildAchievementItem(entry.value, delay: entry.key * 200),
          )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(AchievementItem achievement, {int delay = 0}) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      color: Color(0xFF172A45),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF64FFDA).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                achievement.icon,
                color: Color(0xFF64FFDA),
                size: 24,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    achievement.description,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: delay.ms).slideX(delay: delay.ms);
  }

  Widget _buildContactSection({Key? key}) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's Connect",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 800.ms),
          SizedBox(height: 20),
          Text(
            "Feel free to reach out for collaborations or just a friendly chat",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                icon: FontAwesomeIcons.linkedin,
                url: "https://linkedin.com/in/saksham-chauhan-252003",
                color: Color(0xFF0077B5),
                delay: 0,
              ),
              SizedBox(width: 20),
              _buildSocialButton(
                icon: FontAwesomeIcons.envelope,
                url: "mailto:saksham252003@gmail.com",
                color: Color(0xFFD14836),
                delay: 200,
              ),
              SizedBox(width: 20),
              _buildSocialButton(
                icon: FontAwesomeIcons.medium,
                url: "https://medium.com/@saksham252003",
                color: Color(0xFF12100E),
                delay: 400,
              ),
              SizedBox(width: 20),
              _buildSocialButton(
                icon: FontAwesomeIcons.github,
                url: "https://github.com/saksham0205",
                color: Colors.white,
                delay: 600,
              ),
            ],
          ),
          SizedBox(height: 60),
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Color(0xFF172A45),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    "Pro Tip",
                    style: TextStyle(
                      color: Color(0xFF64FFDA),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "\"The best error message is the one that never shows up.\"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Always available for discussing Flutter optimizations, state management solutions, or UX best practices!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 600.ms).scale(delay: 800.ms),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
    required Color color,
    required int delay,
  }) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: color.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: delay.ms).scale(delay: delay.ms);
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Text(
            "Designed & Built by Saksham",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "© 2025 All Rights Reserved",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class SkillItem {
  final String name;
  final IconData iconData;
  final Color color;

  SkillItem({
    required this.name,
    required this.iconData,
    required this.color,
  });
}

class ProjectItem {
  final String title;
  final String description;
  final List<String> technologies;
  final String url;
  final Color color;

  ProjectItem({
    required this.title,
    required this.description,
    required this.technologies,
    required this.url,
    required this.color,
  });
}

class AchievementItem {
  final String title;
  final String description;
  final IconData icon;

  AchievementItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}