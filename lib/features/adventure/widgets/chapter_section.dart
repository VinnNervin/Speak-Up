import 'package:flutter/material.dart';
import 'package:first_app/features/adventure/models/chapter_model.dart';
import 'package:first_app/features/adventure/widgets/chapter_header.dart';
import 'package:first_app/features/adventure/widgets/stage_card.dart';

class ChapterSection extends StatelessWidget {
  final ChapterModel chapter;
  final Function(String) onStagePressed;

  const ChapterSection({
    super.key,
    required this.chapter,
    required this.onStagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: ChapterHeader(chapter: chapter)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => StageCard(
                stage: chapter.stages[index],
                onStagePressed: onStagePressed,
              ),
              childCount: chapter.stages.length,
            ),
          ),
        ),
      ],
    );
  }
}
