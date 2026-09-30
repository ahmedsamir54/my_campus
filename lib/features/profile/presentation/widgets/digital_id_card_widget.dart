import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/profile_entities.dart';

class DigitalIdCardWidget extends StatelessWidget {
  final StudentProfileEntity profile;
  final bool showBarcode;
  final VoidCallback onToggleViewMode;

  const DigitalIdCardWidget({
    super.key,
    required this.profile,
    required this.showBarcode,
    required this.onToggleViewMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF073A27),
            Color(0xFF006B4D),
            Color(0xFF004D36),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF004D36).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF34D399).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          // 1. PVC Card Header with University Brand & Security Chip
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SOFTTAQWA UNIVERSITY',
                          style: AppTypography.labelBold.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'OFFICIAL DIGITAL STUDENT PASS',
                          style: AppTypography.caption.copyWith(
                            color: const Color(0xFFA7F3D0),
                            fontSize: 9,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Security NFC Wave Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.nfc_rounded,
                        color: Color(0xFF6EE7B7),
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'NFC ACTIVE',
                        style: TextStyle(
                          color: Color(0xFF6EE7B7),
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            color: Colors.white12,
            height: 1,
            indent: 20,
            endIndent: 20,
          ),

          // 2. Student Identity Row: Avatar + Details + Hologram Chip
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Student Portrait Avatar
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 72,
                      height: 84,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFF6EE7B7),
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: AssetImage(profile.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    // Verified Checkmark Dot
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 16),

                // Name, ID, Department & Blood Group
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: AppTypography.heading2.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFA7F3D0)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              profile.studentIdNumber,
                              style: const TextStyle(
                                color: Color(0xFFA7F3D0),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.redAccent.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              'Blood: ${profile.bloodGroup}',
                              style: const TextStyle(
                                color: Color(0xFFFCA5A5),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        profile.department,
                        style: AppTypography.caption.copyWith(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Batch ${profile.batch} • Valid Thru ${profile.validUntil}',
                        style: AppTypography.caption.copyWith(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Scanner Window (Turnstiles Barcode or Academic QR Code)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Mode Toggle Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          showBarcode
                              ? Icons.view_column_rounded
                              : Icons.qr_code_2_rounded,
                          size: 16,
                          color: AppColors.primaryDark,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          showBarcode
                              ? 'Campus Turnstile & Library Barcode'
                              : 'Academic Verification QR Code',
                          style: AppTypography.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimaryLight,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: onToggleViewMode,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              showBarcode
                                  ? Icons.qr_code_rounded
                                  : Icons.barcode_reader,
                              size: 13,
                              color: AppColors.primaryDark,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              showBarcode ? 'Switch to QR' : 'Switch to Barcode',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Interactive Barcode or QR View
                if (showBarcode) ...[
                  // Turnstile & Library Barcode (Code128)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 52,
                          width: double.infinity,
                          child: BarcodeWidget(
                            barcode: Barcode.code128(),
                            data: profile.barcodeValue,
                            drawText: false,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.barcodeValue,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                            color: AppColors.textPrimaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Academic Security QR Code
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderSubtle),
                      ),
                      child: QrImageView(
                        data: profile.qrPayload,
                        version: QrVersions.auto,
                        size: 110,
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: AppColors.primaryDark,
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Color(0xFF073A27),
                        ),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 8),

                Text(
                  showBarcode
                      ? 'Hold near optical turnstile reader for automated gate entry'
                      : 'Scan via university administration app to verify student credentials',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textMutedLight,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
