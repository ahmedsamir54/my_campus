import 'package:flutter/material.dart';
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
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF8ED2EB), // Sky blue
            Color(0xFFBCE3F2),
            Color(0xFFD4EBD6), // Campus lawn tint
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Architectural campus panorama vector background
            CustomPaint(
              size: const Size(double.infinity, 140),
              painter: _CampusArchitecturePainter(),
            ),

            // Top gradient overlay for contrast
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.05),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
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

class _CampusArchitecturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Trees and landscaping
    final hillPaint = Paint()..color = const Color(0xFF6E9F6E);
    final hillPath = Path()
      ..moveTo(0, size.height * 0.75)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.65, size.width * 0.5, size.height * 0.72)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.78, size.width, size.height * 0.7)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(hillPath, hillPaint);

    // Brick buildings left
    final buildingPaint = Paint()..color = const Color(0xFFB86754);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.08, size.height * 0.35, size.width * 0.26, size.height * 0.45), buildingPaint);

    // Left building roof
    final roofPaint = Paint()..color = const Color(0xFF8B4232);
    final roofPathLeft = Path()
      ..moveTo(size.width * 0.06, size.height * 0.35)
      ..lineTo(size.width * 0.21, size.height * 0.22)
      ..lineTo(size.width * 0.36, size.height * 0.35)
      ..close();
    canvas.drawPath(roofPathLeft, roofPaint);

    // Right building
    canvas.drawRect(Rect.fromLTWH(size.width * 0.66, size.height * 0.35, size.width * 0.26, size.height * 0.45), buildingPaint);
    final roofPathRight = Path()
      ..moveTo(size.width * 0.64, size.height * 0.35)
      ..lineTo(size.width * 0.79, size.height * 0.22)
      ..lineTo(size.width * 0.94, size.height * 0.35)
      ..close();
    canvas.drawPath(roofPathRight, roofPaint);

    // Center Clock Tower
    final towerPaint = Paint()..color = const Color(0xFFC77864);
    final towerLeft = size.width * 0.45;
    final towerWidth = size.width * 0.10;
    canvas.drawRect(Rect.fromLTWH(towerLeft, size.height * 0.25, towerWidth, size.height * 0.55), towerPaint);

    // Clock tower spire
    final spirePaint = Paint()..color = const Color(0xFF4C7063);
    final spirePath = Path()
      ..moveTo(towerLeft - 2, size.height * 0.25)
      ..lineTo(towerLeft + (towerWidth / 2), size.height * 0.10)
      ..lineTo(towerLeft + towerWidth + 2, size.height * 0.25)
      ..close();
    canvas.drawPath(spirePath, spirePaint);

    // Clock Face circle
    final clockPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(towerLeft + (towerWidth / 2), size.height * 0.33), 6, clockPaint);
    final clockRim = Paint()
      ..color = const Color(0xFF5A3026)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(Offset(towerLeft + (towerWidth / 2), size.height * 0.33), 6, clockRim);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
