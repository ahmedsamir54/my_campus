import 'package:flutter/material.dart';
import 'package:my_campus/core/constants/app_assets.dart';
import 'package:my_campus/core/constants/app_typography.dart';

class CampusHeroBanner extends StatelessWidget {
  final String weather;
  final String semester;

  const CampusHeroBanner({
    super.key,
    this.weather = 'Sunny 28°C',
    this.semester = "SPRING '26",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Campus illustration image from assets
            Image.asset(
              AppAssets.campusIllustration,
              fit: BoxFit.cover,
            ),

            // Subtle dark gradient overlay at bottom for tag readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.05),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),

            // Bottom Labels
            Positioned(
              bottom: 12,
              left: 14,
              right: 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // University & Spring tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'CENTRAL UNIVERSITY • $semester',
                      style: AppTypography.badgeText.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  // Weather Widget
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('☀️ ', style: TextStyle(fontSize: 11)),
                        Text(
                          weather,
                          style: AppTypography.badgeText.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
