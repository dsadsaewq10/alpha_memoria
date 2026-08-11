import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/date_formatter.dart';
import '../../models/alert_model.dart';
import '../common/app_card.dart';

class AlertTile extends StatelessWidget {
  final AlertModel alert;
  final VoidCallback onTap;
  final VoidCallback? onActionTap;

  const AlertTile({
    super.key,
    required this.alert,
    required this.onTap,
    this.onActionTap,
  });

  IconData _getAlertIcon(AlertType type) {
    switch (type) {
      case AlertType.success:
        return Icons.check_circle_rounded;
      case AlertType.info:
        return Icons.info_rounded;
      case AlertType.reminder:
        return Icons.warning_amber_rounded;
      case AlertType.warning:
        return Icons.notifications_active_rounded;
    }
  }

  Color _getAlertColor(AlertType type) {
    switch (type) {
      case AlertType.success:
        return AppColors.success;
      case AlertType.info:
        return AppColors.primary;
      case AlertType.reminder:
        return AppColors.error;
      case AlertType.warning:
        return AppColors.warning;
    }
  }

  Color _getAlertBg(AlertType type) {
    switch (type) {
      case AlertType.success:
        return AppColors.successLight;
      case AlertType.info:
        return AppColors.primaryLight;
      case AlertType.reminder:
        return AppColors.errorLight;
      case AlertType.warning:
        return AppColors.warningLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getAlertColor(alert.type);
    final bg = _getAlertBg(alert.type);

    return AppCard(
      onTap: onTap,
      backgroundColor: alert.isRead ? Colors.white : AppColors.primarySubtle,
      border: BorderSide(
        color: alert.isRead ? AppColors.border : AppColors.primaryLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
            ),
            child: Icon(_getAlertIcon(alert.type), color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        alert.title,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: alert.isRead ? FontWeight.w600 : FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      DateFormatter.formatRelativeDays(alert.timestamp),
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  alert.message,
                  style: AppTextStyles.bodyMedium,
                ),
                if (alert.actionLabel != null) ...[
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      minimumSize: const Size(0, 32),
                    ),
                    onPressed: onActionTap,
                    child: Text(
                      alert.actionLabel!,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
