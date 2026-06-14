import 'package:first_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomepageNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomepageNavigation({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70,
        decoration: BoxDecoration(color: AppColors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bulilNavItem(0, Icons.house),
            _bulilNavItem(1, Icons.menu_book),
            _bulilNavItem(2, LucideIcons.dumbbell),
            _bulilNavItem(3, Icons.account_circle_outlined),
            _bulilNavItem(4, Icons.account_circle_outlined),
          ],
        ),
      ),
    );
  }

  Widget _bulilNavItem(int index, IconData icon) {
    bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isActive ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(icon, color: isActive ? AppColors.primary : AppColors.primaryAccent, size: 30),
      ),
    );
  }
}
