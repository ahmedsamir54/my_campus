import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/status_badge.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/academic_metrics_grid.dart';
import '../widgets/digital_id_card_widget.dart';
import '../widgets/settings_and_security_section.dart';
import '../widgets/student_details_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.logout_rounded, color: AppColors.danger),
            const SizedBox(width: 8),
            Text(
              'Confirm Log Out',
              style: AppTypography.heading3.copyWith(fontSize: 17),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to end your active session on this device? Your offline digital pass will remain encrypted on your device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Logged out of SoftTaqwa University Session'),
                  backgroundColor: AppColors.primaryDark,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _showDownloadPdfNotice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Digital ID Pass (PDF) saved to device downloads!'),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is ProfileError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 48,
                        color: AppColors.danger,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Failed to load profile',
                        style: AppTypography.heading3,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        state.message,
                        style: AppTypography.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ProfileCubit>().loadProfile(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ProfileLoaded) {
              final data = state.data;
              final profile = data.profile;
              final academic = data.academic;
              final settings = data.settings;

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () => context.read<ProfileCubit>().loadProfile(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Strip
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.badge_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Digital Pass ID',
                                style: AppTypography.heading3.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const StatusBadge(
                            label: 'Verified Student',
                            type: BadgeType.success,
                            hasDot: true,
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // 1. Digital PVC Student ID Card (NFC + Photo + Barcode/QR)
                      DigitalIdCardWidget(
                        profile: profile,
                        showBarcode: state.showBarcode,
                        onToggleViewMode: () =>
                            context.read<ProfileCubit>().toggleIdViewMode(),
                      ),

                      const SizedBox(height: 16),

                      // 2. Academic Metrics (CGPA, Credits, Courses)
                      AcademicMetricsGrid(academic: academic),

                      const SizedBox(height: 16),

                      // 3. Student Details & Institutional Record
                      StudentDetailsCard(
                        profile: profile,
                        academic: academic,
                      ),

                      const SizedBox(height: 16),

                      // 4. Settings, Security Toggles & Logout
                      SettingsAndSecuritySection(
                        settings: settings,
                        onToggleBiometrics: (enabled) => context
                            .read<ProfileCubit>()
                            .toggleBiometrics(enabled),
                        onToggleNotifications: (enabled) => context
                            .read<ProfileCubit>()
                            .toggleNotifications(enabled),
                        onDownloadPdf: () => _showDownloadPdfNotice(context),
                        onLogout: () => _showLogoutDialog(context),
                      ),

                      const SizedBox(height: 28),
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
}
