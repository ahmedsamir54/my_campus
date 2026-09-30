import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_campus/core/constants/app_colors.dart';
import 'package:my_campus/core/constants/app_typography.dart';
import 'package:my_campus/core/widgets/custom_app_bar.dart';
import 'package:my_campus/core/widgets/custom_bottom_nav.dart';
import 'package:my_campus/injection_container.dart';
import '../../dashboard/presentation/cubit/dashboard_cubit.dart';
import '../../dashboard/presentation/pages/dashboard_page.dart';
import '../../routine/presentation/cubit/routine_cubit.dart';
import '../../routine/presentation/pages/routine_page.dart';

class MainNavigationShell extends StatefulWidget {
  final int initialIndex;

  const MainNavigationShell({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Tab 0: Home (Dashboard)
      BlocProvider(
        create: (_) => sl<DashboardCubit>()..loadDashboard(),
        child: DashboardPage(
          onSwitchTab: _onTabSelected,
          onNavigateRoute: (route) {
            _showUnderConstructionSnackbar(route);
          },
        ),
      ),
      // Tab 1: Classes (Routine)
      BlocProvider(
        create: (_) => sl<RoutineCubit>()..loadWeeklyRoutine(),
        child: const RoutinePage(),
      ),
      // Tab 2: Notices
      _buildTabPlaceholder(
        title: 'Campus Notices & Circulars',
        subtitle: 'Official circulars, examinations and sports feeds',
        icon: Icons.article_rounded,
      ),
      // Tab 3: Messages
      _buildTabPlaceholder(
        title: 'Academic Messaging',
        subtitle: 'Faculty channels, live office hours and study groups',
        icon: Icons.chat_bubble_rounded,
      ),
      // Tab 4: Profile
      _buildTabPlaceholder(
        title: 'Student Profile & Digital ID Pass',
        subtitle: 'Sprint 2: Screen 4 (PVC ID, Barcode, NFC)',
        icon: Icons.person_rounded,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(
        isDashboard: _currentIndex == 0,
        title: _getAppBarTitle(_currentIndex),
        subtitle: _getAppBarSubtitle(_currentIndex),
        showBackButton: false,
        onNotificationTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('3 Unread Campus Notifications'),
              backgroundColor: AppColors.primaryDark,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        },
        onProfileTap: () => _onTabSelected(4),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 1:
        return 'Class Routine';
      case 2:
        return 'Campus Notices';
      case 3:
        return 'Messages';
      case 4:
        return 'Student Profile';
      default:
        return 'MyCampus';
    }
  }

  String? _getAppBarSubtitle(int index) {
    switch (index) {
      case 1:
        return 'Fall 2026 • Week 7';
      case 2:
        return 'Official University Circulars';
      case 3:
        return 'Faculty & Academic Channels';
      case 4:
        return 'Verified Campus ID';
      default:
        return null;
    }
  }

  Widget _buildTabPlaceholder({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTypography.heading3.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showUnderConstructionSnackbar(String route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Module "$route" queued on roadmap!'),
        backgroundColor: AppColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
