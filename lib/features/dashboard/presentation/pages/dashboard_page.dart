import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_campus/core/constants/app_colors.dart';
import 'package:my_campus/core/constants/app_typography.dart';
import '../../domain/entities/dashboard_entities.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/campus_hero_banner.dart';
import '../widgets/featured_campus_event_card.dart';
import '../widgets/next_class_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/student_greeting_header.dart';

class DashboardPage extends StatelessWidget {
  final Function(int)? onSwitchTab;
  final Function(String route)? onNavigateRoute;

  const DashboardPage({
    super.key,
    this.onSwitchTab,
    this.onNavigateRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is DashboardError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.danger),
                    const SizedBox(height: 12),
                    Text('Failed to load dashboard', style: AppTypography.heading3),
                    const SizedBox(height: 6),
                    Text(state.message, style: AppTypography.bodyMedium),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<DashboardCubit>().loadDashboard(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            if (state is DashboardLoaded) {
              final data = state.data;

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () => context.read<DashboardCubit>().loadDashboard(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Campus Hero Panorama Banner
                      CampusHeroBanner(
                        weather: data.weather,
                        semester: data.semester,
                      ),
                      const SizedBox(height: 16),

                      // 2. Student Greeting & Online Avatar
                      StudentGreetingHeader(
                        studentName: data.studentName,
                        status: data.studentStatus,
                        onAvatarTap: () {
                          if (onSwitchTab != null) onSwitchTab!(4); // Profile tab
                        },
                      ),
                      const SizedBox(height: 16),

                      // 3. Next Class Alert Card
                      NextClassCard(
                        nextClass: data.nextClass,
                        onTap: () {
                          if (onSwitchTab != null) onSwitchTab!(1); // Classes tab
                        },
                      ),
                      const SizedBox(height: 20),

                      // 4. Quick Actions 4x2 Grid
                      QuickActionsGrid(
                        actions: data.quickActions,
                        semester: data.semester,
                        onActionTap: (action) {
                          _handleQuickAction(context, action);
                        },
                      ),
                      const SizedBox(height: 20),

                      // 5. Featured Campus Event Card
                      FeaturedCampusEventCard(
                        event: data.featuredEvent,
                        onRegisterTap: () {
                          _showEventRegistrationSheet(context, data.featuredEvent);
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _handleQuickAction(BuildContext context, QuickActionItemEntity action) {
    switch (action.id) {
      case 'classes':
        if (onSwitchTab != null) onSwitchTab!(1);
        break;
      case 'notices':
        if (onSwitchTab != null) onSwitchTab!(2);
        break;
      case 'profile':
        if (onSwitchTab != null) onSwitchTab!(4);
        break;
      default:
        if (onNavigateRoute != null) {
          onNavigateRoute!(action.route);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${action.label} module selected'),
              duration: const Duration(seconds: 1),
              backgroundColor: AppColors.primaryDark,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
        break;
    }
  }

  void _showEventRegistrationSheet(BuildContext context, FeaturedEventEntity event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Event Registration',
                  style: AppTypography.heading3.copyWith(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(event.title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(event.description, style: AppTypography.bodyMedium),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  context.read<DashboardCubit>().registerEvent(event.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('RSVP Confirmed! Saved to local storage.'),
                      backgroundColor: AppColors.success,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                child: const Text('Confirm Free Reservation', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
