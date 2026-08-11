import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class ThemeSelectorWidget extends StatelessWidget {
  final List<String> themes;
  final String selectedTheme;
  final ValueChanged<String> onThemeSelected;

  const ThemeSelectorWidget({
    super.key,
    required this.themes,
    required this.selectedTheme,
    required this.onThemeSelected,
  });

  IconData _getThemeIcon(String theme) {
    switch (theme.toLowerCase()) {
      case 'minimalist':
        return Icons.crop_portrait_rounded;
      case 'floral':
        return Icons.local_florist_rounded;
      case 'retro':
        return Icons.camera_roll_rounded;
      case 'glamour':
        return Icons.auto_awesome_rounded;
      case 'neon nights':
      case 'neon':
        return Icons.wb_twilight_rounded;
      default:
        return Icons.style_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: themes.length,
        separatorBuilder: (ctx, i) => const SizedBox(width: 12),
        itemBuilder: (ctx, index) {
          final theme = themes[index];
          final isSelected = theme == selectedTheme;

          return GestureDetector(
            onTap: () => onThemeSelected(theme),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 80,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLight : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getThemeIcon(theme),
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    theme,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
