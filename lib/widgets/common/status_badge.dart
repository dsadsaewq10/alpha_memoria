import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status.toLowerCase()) {
      case 'confirmed':
        bg = AppColors.successLight;
        fg = AppColors.success;
        break;
      case 'pending':
      case 'pending verification':
        bg = AppColors.warningLight;
        fg = AppColors.warning;
        break;
      case 'completed':
        bg = AppColors.primaryLight;
        fg = AppColors.primary;
        break;
      case 'cancelled':
        bg = AppColors.errorLight;
        fg = AppColors.error;
        break;
      default:
        bg = AppColors.primaryLight;
        fg = AppColors.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: AppTextStyles.caption.copyWith(
          color: fg,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
