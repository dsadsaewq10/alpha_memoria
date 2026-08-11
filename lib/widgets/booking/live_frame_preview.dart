import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class LiveFramePreview extends StatelessWidget {
  final String theme;
  final Color primaryColor;
  final String customText;
  final String fontStyle;

  const LiveFramePreview({
    super.key,
    required this.theme,
    required this.primaryColor,
    required this.customText,
    required this.fontStyle,
  });

  TextStyle _getHeadingFont() {
    switch (fontStyle.toLowerCase()) {
      case 'elegant script':
        return GoogleFonts.dancingScript(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
      case 'vintage serif':
        return GoogleFonts.playfairDisplay(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
      case 'bold playful':
        return GoogleFonts.fredoka(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
      case 'modern sans':
      default:
        return GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          // Live Preview Badge
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(
              color: AppColors.primarySubtle,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.remove_red_eye_rounded, size: 14, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  'LIVE PREVIEW',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),

          // Photo Strip Frame Card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  // Sample Photo Container
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Image.network(
                          'https://images.unsplash.com/photo-1511795409834-ef04bbd61622',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Container(
                            height: 150,
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(Icons.people_rounded, size: 48, color: Colors.white),
                            ),
                          ),
                        ),
                        // Watermark / Overlay Theme icon
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              theme,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Customized Banner Text
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      customText.isEmpty ? 'Happy 30th Birthday Juanita!' : customText,
                      style: _getHeadingFont(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
