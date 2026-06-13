import 'package:flutter/material.dart';
import 'package:first_app/theme/app_colors.dart';
import 'package:first_app/theme/app_fonts.dart';

class DailyChest extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const DailyChest({
    super.key,
    this.title = 'Peti Hadiah Harian',
    this.subtitle = 'Selesaikan 3 misi\nuntuk membuka peti!',
    this.icon = Icons.card_giftcard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppFonts.fontMedium,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.8),
                    fontSize: AppFonts.fontSmall,
                  ),
                ),
              ],
            ),
          ),
          Icon(icon, size: 60, color: AppColors.white),
        ],
      ),
    );
  }
}
