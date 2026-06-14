import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_app/theme/app_colors.dart';
import 'package:first_app/theme/app_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:first_app/core/controllers/language_controller.dart';

// ─── Data Model ─────────────────────────────────────────────────────────────
class _Language {
  final String code;
  final String name;
  final String nativeName;
  final String? flagAsset; // local asset path, null = pakai emoji
  final String flagEmoji;

  const _Language({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flagEmoji,
    this.flagAsset,
  });
}

// Daftar bahasa yang tersedia (Hanya English dan Chinese)
const List<_Language> _availableLanguages = [
  _Language(
    code: 'en',
    name: 'English',
    nativeName: 'English',
    flagEmoji: '🇬🇧',
    flagAsset: 'assets/images/flags/english.png',
  ),
  _Language(
    code: 'zh',
    name: 'Chinese',
    nativeName: '中文',
    flagEmoji: '🇨🇳',
    flagAsset: 'assets/images/flags/chinese.png',
  ),
];

// ─── Page ────────────────────────────────────────────────────────────────────
class PlaceholderPage extends StatefulWidget {
  const PlaceholderPage({super.key});

  @override
  State<PlaceholderPage> createState() => _PlaceholderPageState();
}

class _PlaceholderPageState extends State<PlaceholderPage> {
  // ── Trigger modal ──────────────────────────────────────────────────────────
  void _showLanguageSelector() {
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

  // ── Build WoltModalSheetPage ───────────────────────────────────────────────
  SliverWoltModalSheetPage _buildLanguageSelectorPage(
    BuildContext modalCtx,
    ValueNotifier<String> tempSelectedCodeNotifier,
    LanguageController controller,
  ) {
    return SliverWoltModalSheetPage(
      backgroundColor: AppColors.white,
      // ── Top bar ─────────────────────────────────────────────────────────
      topBarTitle: Text(
        'Select Language / 选择语言',
        style: GoogleFonts.inter(
          fontSize: AppFonts.fontMedium,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1A1A2E),
        ),
      ),
      isTopBarLayerAlwaysVisible: true,
      hasTopBarLayer: true,
      trailingNavBarWidget: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: IconButton(
          icon: const Icon(Icons.close_rounded, color: Color(0xFF1A1A2E)),
          onPressed: Navigator.of(modalCtx).pop,
        ),
      ),
      hasSabGradient: true,
      // ── SAB: tombol "Apply" ──────────────────────────────────────────────
      stickyActionBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: ValueListenableBuilder<String>(
          valueListenable: tempSelectedCodeNotifier,
          builder: (ctx, tempCode, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              onPressed: () {
                controller.changeLanguage(tempCode);
                Navigator.of(modalCtx).pop();
              },
              child: Text(
                'Apply Language / 应用语言',
                style: GoogleFonts.inter(
                  fontSize: AppFonts.fontMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ),
      // ── Main content ─────────────────────────────────────────────────────
      mainContentSliversBuilder: (ctx) => [
        // Sub-header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(
              'Choose your preferred language for the app interface.\n请选择您偏好的应用界面语言。',
              style: GoogleFonts.inter(
                fontSize: AppFonts.fontSmall,
                color: const Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
          ),
        ),
        // Language list
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
          sliver: ValueListenableBuilder<String>(
            valueListenable: tempSelectedCodeNotifier,
            builder: (context, tempCode, child) {
              return SliverList.separated(
                itemCount: _availableLanguages.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  final lang = _availableLanguages[index];
                  return _LanguageTile(
                    language: lang,
                    isSelected: tempCode == lang.code,
                    onTap: () {
                      tempSelectedCodeNotifier.value = lang.code;
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

  // ── Main UI ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final languageController = context.watch<LanguageController>();
    final selectedLanguage = _availableLanguages.firstWhere(
      (l) => l.code == languageController.selectedLanguageCode,
      orElse: () => _availableLanguages.first,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon globe
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(70),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.language_rounded, size: 44, color: Colors.white),
              ),
              const SizedBox(height: 24),
              Text(
                'App Language',
                style: GoogleFonts.inter(
                  fontSize: AppFonts.fontLarge,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Currently set to',
                style: GoogleFonts.inter(
                  fontSize: AppFonts.fontSmall,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 20),
              // Current language card
              _CurrentLanguageCard(language: selectedLanguage),
              const SizedBox(height: 32),
              // Trigger button
              GestureDetector(
                onTap: _showLanguageSelector,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.purple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(80),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.swap_horiz_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Change Language',
                        style: GoogleFonts.inter(
                          fontSize: AppFonts.fontMedium,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
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

// ─── Current Language Card ────────────────────────────────────────────────────
class _CurrentLanguageCard extends StatelessWidget {
  final _Language language;
  const _CurrentLanguageCard({required this.language});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(20),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _FlagWidget(language: language, size: 40),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                language.name,
                style: GoogleFonts.inter(
                  fontSize: AppFonts.fontMedium,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              Text(
                language.nativeName,
                style: GoogleFonts.inter(
                  fontSize: AppFonts.fontSmall,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              language.code.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Language Tile ────────────────────────────────────────────────────────────
class _LanguageTile extends StatelessWidget {
  final _Language language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageTile({required this.language, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryLight : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? AppColors.primary : const Color(0xFFE5E7EB),
          width: isSelected ? 2.0 : 1.0,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primary.withAlpha(30),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        splashColor: AppColors.primary.withAlpha(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Flag
              _FlagWidget(language: language, size: 44),
              const SizedBox(width: 14),
              // Labels
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.name,
                      style: GoogleFonts.inter(
                        fontSize: AppFonts.fontMedium,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? AppColors.primary : const Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      language.nativeName,
                      style: GoogleFonts.inter(
                        fontSize: AppFonts.fontSmall,
                        color: isSelected ? AppColors.primaryAccent : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              // Language code badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  language.code.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : const Color(0xFF6B7280),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Checkmark
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isSelected
                    ? Container(
                        key: const ValueKey('check'),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: const Icon(Icons.check_rounded, color: Colors.white, size: 16),
                      )
                    : Container(
                        key: const ValueKey('empty'),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFD1D5DB), width: 1.5),
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

// ─── Flag Widget ──────────────────────────────────────────────────────────────
class _FlagWidget extends StatelessWidget {
  final _Language language;
  final double size;

  const _FlagWidget({required this.language, required this.size});

  @override
  Widget build(BuildContext context) {
    final asset = language.flagAsset;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.22),
      child: SizedBox(
        width: size,
        height: size,
        child: asset != null
            ? Image.asset(asset, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _emojiFallback())
            : _emojiFallback(),
      ),
    );
  }

  Widget _emojiFallback() {
    return Container(
      color: const Color(0xFFF3F4F6),
      alignment: Alignment.center,
      child: Text(language.flagEmoji, style: TextStyle(fontSize: size * 0.55)),
    );
  }
}
