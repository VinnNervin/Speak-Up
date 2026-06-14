import 'package:first_app/core/widgets/HomepageHeader/Model/LanguageOption.dart';
import 'package:first_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:first_app/core/widgets/ImageBox/image_box.dart';
import 'package:first_app/theme/app_colors.dart';
import 'package:first_app/theme/app_sizing.dart';
import 'package:first_app/theme/app_fonts.dart';
import 'package:first_app/core/controllers/language_controller.dart';

const List<LanguageOption> _languageOptions = [
  LanguageOption(
    code: 'en',
    name: 'Bahasa Inggris',
    nativeName: 'English',
    flagAsset: 'assets/images/flags/english.png',
  ),
  LanguageOption(
    code: 'zh',
    name: 'Bahasa Mandarin',
    nativeName: '中文',
    flagAsset: 'assets/images/flags/chinese.png',
  ),
];

// ─── Main Orchestrator Widget ───────────────────────────────────────────────
class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizing.paddingSM,
          vertical: AppSizing.paddingXS,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_UserProfileSection(), _HeaderActionsSection()],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}

// ─── User Profile Section ───────────────────────────────────────────────────
class _UserProfileSection extends StatelessWidget {
  const _UserProfileSection();

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final userName = authController.user?.name ?? "Guest";

    return Row(
      spacing: 10,
      children: [
        ImageBox.network("https://i.pravatar.cc/150?img=12"),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.black),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Header Actions Section ─────────────────────────────────────────────────
class _HeaderActionsSection extends StatelessWidget {
  const _HeaderActionsSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _LanguageFlagButton(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded, size: 26)),
      ],
    );
  }
}

// ─── Language Flag Button ───────────────────────────────────────────────────
class _LanguageFlagButton extends StatelessWidget {
  const _LanguageFlagButton();

  void _showLanguageSelector(BuildContext context) {
    final languageController = context.read<LanguageController>();
    final tempSelectedCodeNotifier = ValueNotifier<String>(languageController.selectedLanguageCode);

    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => WoltModalType.bottomSheet(),
      pageListBuilder: (modalCtx) => [
        _buildLanguageSelectorPage(modalCtx, tempSelectedCodeNotifier, languageController),
      ],
    );
  }

  SliverWoltModalSheetPage _buildLanguageSelectorPage(
    BuildContext modalCtx,
    ValueNotifier<String> tempSelectedCodeNotifier,
    LanguageController controller,
  ) {
    return SliverWoltModalSheetPage(
      backgroundColor: AppColors.white,
      // ── Top Bar ───────────────────────────────────────────────────────────
      topBarTitle: Text(
        'Pilih Bahasa Pelajaran',
        style: TextStyle(fontSize: AppFonts.fontLarge, color: AppColors.black),
      ),
      isTopBarLayerAlwaysVisible: true,
      hasTopBarLayer: true,
      trailingNavBarWidget: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.black),
          onPressed: Navigator.of(modalCtx).pop,
        ),
      ),
      hasSabGradient: true,
      stickyActionBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: ValueListenableBuilder<String>(
          valueListenable: tempSelectedCodeNotifier,
          builder: (ctx, tempCode, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              onPressed: () {
                controller.changeLanguage(tempCode);
                Navigator.of(modalCtx).pop();
              },
              child: const Text(
                'Terapkan Pelajaran',
                style: TextStyle(fontSize: AppFonts.fontLarge),
              ),
            );
          },
        ),
      ),
      mainContentSliversBuilder: (ctx) => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              'Pilih bahasa yang ingin Anda pelajari.',
              style: TextStyle(fontSize: AppFonts.fontMedium, color: AppColors.black),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
          sliver: ValueListenableBuilder<String>(
            valueListenable: tempSelectedCodeNotifier,
            builder: (context, tempCode, child) {
              return SliverList.separated(
                itemCount: _languageOptions.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, index) {
                  final option = _languageOptions[index];
                  return _LanguageOptionTile(
                    option: option,
                    isSelected: tempCode == option.code,
                    onTap: () {
                      tempSelectedCodeNotifier.value = option.code;
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeFlag = context.watch<LanguageController>().selectedLanguageFlag;

    return GestureDetector(
      onTap: () => _showLanguageSelector(context),
      child: SizedBox(width: 35, height: 35, child: Image.asset(activeFlag, fit: BoxFit.cover)),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  final LanguageOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOptionTile({required this.option, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryLight : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizing.radiusMD),
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.grey, width: 2.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizing.radiusSM),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizing.radiusSM),
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: Image.asset(option.flagAsset, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.name,
                      style: TextStyle(
                        fontSize: AppFonts.fontMedium,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? AppColors.primary : AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      option.nativeName,
                      style: TextStyle(
                        fontSize: AppFonts.fontSmall,
                        color: isSelected ? AppColors.primaryAccent : AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isSelected
                    ? Container(
                        key: const ValueKey('check'),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: const Icon(Icons.check_rounded, color: AppColors.white, size: 16),
                      )
                    : Container(
                        key: const ValueKey('empty'),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.grey, width: 1.5),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
