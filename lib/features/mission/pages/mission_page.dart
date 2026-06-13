import 'package:flutter/material.dart';
import 'package:first_app/theme/app_colors.dart';
import 'package:first_app/theme/app_fonts.dart';
import 'package:first_app/theme/app_sizing.dart';
import 'package:first_app/features/mission/controllers/mission_controller.dart';
import 'package:first_app/features/mission/widgets/mission_list.dart';
import 'package:first_app/features/mission/widgets/daily_chest.dart';
import 'package:first_app/core/widgets/Calendar/calendar.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({super.key});

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  final MissionController _controller = MissionController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _controller.init();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: const Text(
            'Misi Saya',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.fontLarge,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.fontMedium,
            ),
            tabs: [
              Tab(text: 'Tugas'),
              Tab(text: 'Lainnya'),
            ],
          ),
        ),
        body: _controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  ListView(
                    padding: EdgeInsets.all(AppSizing.paddingMD),
                    children: [
                      const AppCalendar(),
                      const SizedBox(height: 20),
                      const DailyChest(),
                      const SizedBox(height: 20),
                      MissionList(missions: _controller.taskMissions),
                    ],
                  ),
                  ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: AppSizing.paddingMD,
                    ),
                    children: const [Text('sksks')],
                  ),
                ],
              ),
      ),
    );
  }
}
