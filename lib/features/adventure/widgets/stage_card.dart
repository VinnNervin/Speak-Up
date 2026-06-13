import 'package:flutter/material.dart';
import 'package:first_app/core/widgets/DynamicButton/Dynamic_Button.dart';
import 'package:first_app/core/widgets/DynamicButton/dynamic_button_config.dart';
import 'package:first_app/features/adventure/models/chapter_model.dart';
import 'package:first_app/theme/app_colors.dart';

class StageCard extends StatelessWidget {
  final StageItemModel stage;
  final Function(String) onStagePressed;

  const StageCard({
    super.key,
    required this.stage,
    required this.onStagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return DynamicButton(
      config: DynamicButtonConfig(
        label: stage.stageName,
        backgroundColor: AppColors.primary,
        shadowColor: AppColors.black.withValues(alpha: 0.5),
        fontColor: AppColors.white,
        onPressed: () => onStagePressed(stage.file),
      ),
    );
  }
}
