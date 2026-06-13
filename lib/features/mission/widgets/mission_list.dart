import 'package:flutter/material.dart';
import 'package:first_app/theme/app_colors.dart';
import 'package:first_app/theme/app_fonts.dart';
import 'package:first_app/features/mission/models/mission_model.dart';
import 'package:first_app/features/mission/widgets/mission_card.dart';

class MissionList extends StatelessWidget {
  final List<MissionModel> missions;

  const MissionList({
    super.key,
    required this.missions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar Misi',
          style: TextStyle(
            fontSize: AppFonts.fontMedium,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 10),
        ...missions.map((mission) => MissionCard(mission: mission)),
      ],
    );
  }
}
