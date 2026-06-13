import 'package:flutter/material.dart';
import 'package:first_app/theme/app_colors.dart';
import 'package:first_app/features/mission/models/mission_model.dart';

class MissionController {
  bool isLoading = false;

  final List<MissionModel> taskMissions = [
    MissionModel(
      title: 'Selesaikan 2 Pelajaran',
      description: 'Belajar apa saja hari ini untuk mendapatkan EXP.',
      icon: Icons.book,
      iconColor: AppColors.primary,
      progress: 0.5,
      progressText: '1/2',
      reward: 50,
    ),
    MissionModel(
      title: 'Latihan Berbicara',
      description: 'Selesaikan 1 sesi latihan pengucapan.',
      icon: Icons.mic,
      iconColor: AppColors.red,
      progress: 0.0,
      progressText: '0/1',
      reward: 30,
    ),
    MissionModel(
      title: 'Dapatkan Nilai Sempurna',
      description: 'Jawab semua pertanyaan benar di satu kuis.',
      icon: Icons.star,
      iconColor: AppColors.orange,
      progress: 1.0,
      progressText: '1/1',
      reward: 100,
      isCompleted: true,
    ),
  ];

  Future<void> init() async {
    isLoading = true;
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }
}
