import 'package:flutter/material.dart';

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
