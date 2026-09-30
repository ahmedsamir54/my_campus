import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/profile_entities.dart';

class SettingsAndSecuritySection extends StatelessWidget {
  final ProfileSettingsEntity settings;
  final Function(bool) onToggleBiometrics;
  final Function(bool) onToggleNotifications;
  final VoidCallback onDownloadPdf;
  final VoidCallback onLogout;

  const SettingsAndSecuritySection({
    super.key,
    required this.settings,
    required this.onToggleBiometrics,
    required this.onToggleNotifications,
    required this.onDownloadPdf,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security & Preferences',
            style: AppTypography.heading3.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),

          // 1. Biometric Authentication Toggle
          _buildSwitchRow(
            icon: Icons.fingerprint_rounded,
            iconColor: AppColors.primary,
            iconBg: AppColors.primaryLight,
            title: 'Biometric Access & Turnstile Auth',
            subtitle: 'Use Face ID / Fingerprint to open gates & lockers',
            value: settings.biometricsEnabled,
            onChanged: onToggleBiometrics,
          ),

          const Divider(height: 18),

          // 2. Notifications Toggle
          _buildSwitchRow(
            icon: Icons.notifications_active_outlined,
            iconColor: const Color(0xFF0284C7),
            iconBg: const Color(0xFFE0F2FE),
            title: 'Push Notifications & Class Alerts',
            subtitle: 'Instant alerts for attendance warnings & exam schedules',
            value: settings.notificationsEnabled,
            onChanged: onToggleNotifications,
          ),

          const Divider(height: 18),

          // 3. Download Offline PDF Pass
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onDownloadPdf,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.picture_as_pdf_rounded,
                        color: Color(0xFF4B5563),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Download Official Digital ID (PDF)',
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryLight,
                            ),
                          ),
                          Text(
                            'Verified university cryptographically signed PDF pass',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textMutedLight,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.download_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // 4. Logout CTA
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onLogout,
              icon: const Icon(
                Icons.logout_rounded,
                size: 18,
                color: AppColors.danger,
              ),
              label: const Text(
                'Log Out Academic Session',
                style: TextStyle(
                  color: AppColors.danger,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.danger.withValues(alpha: 0.3)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppColors.dangerLight.withValues(alpha: 0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              Text(
                subtitle,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textMutedLight,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          activeTrackColor: AppColors.primary,
          activeThumbColor: Colors.white,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
