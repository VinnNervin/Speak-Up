import 'package:first_app/features/adventure/controllers/adventure_controller.dart';
import 'package:first_app/features/adventure/widgets/chapter_section.dart';
import 'package:first_app/features/stage/pages/stage_page.dart';
import 'package:first_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AdventureLayout extends StatefulWidget {
  const AdventureLayout({super.key});

  @override
  State<AdventureLayout> createState() => _AdventureLayoutState();
}

class _AdventureLayoutState extends State<AdventureLayout> {
  final AdventureController _controller = AdventureController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _controller.init();
    if (mounted) setState(() {});
  }

  void _navigateToStage(String filePath) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StagePage(filePath: filePath)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      color: AppColors.white,
      child: CustomScrollView(
        slivers: [
          ..._controller.chapters.map(
            (chapter) => ChapterSection(
              chapter: chapter,
              onStagePressed: _navigateToStage,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }
}
