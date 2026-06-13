import 'package:flutter/material.dart';

class MissionModel {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final double progress;
  final String progressText;
  final int reward;
  final bool isCompleted;

  MissionModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.progress,
    required this.progressText,
    required this.reward,
    this.isCompleted = false,
  });
}
