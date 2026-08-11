import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/utils/date_formatter.dart';
import '../../models/package_model.dart';
import '../common/app_card.dart';
import '../common/status_badge.dart';

class OrderSummaryCard extends StatelessWidget {
  final PackageModel package;
  final DateTime date;
  final String timeSlot;
  final String venueLocation;
  final String eventType;
  final int guestCount;
  final String frameTheme;
  final String? status;

  const OrderSummaryCard({
    super.key,
    required this.package,
    required this.date,
    required this.timeSlot,
    required this.venueLocation,
    required this.eventType,
    required this.guestCount,
    required this.frameTheme,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Summary',
                style: AppTextStyles.headingSmall,
              ),
              if (status != null) StatusBadge(status: status!),
            ],
          ),
          const Divider(height: 24, color: AppColors.border),

          // Package Info Row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  package.imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    width: 56,
                    height: 56,
                    color: AppColors.primaryLight,
                    child: const Icon(Icons.camera_alt_rounded, color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.name,
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${package.durationHours} Hours Service',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Text(
                CurrencyFormatter.format(package.price),
                style: AppTextStyles.headingSmall.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Booking Details Grid
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildDetailRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Date & Time',
                  value: '${DateFormatter.formatShortDate(date)} • $timeSlot',
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  icon: Icons.location_on_rounded,
                  label: 'Location',
                  value: venueLocation.isEmpty ? 'The Grand Plaza' : venueLocation,
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  icon: Icons.celebration_rounded,
                  label: 'Event Type',
                  value: '$eventType ($guestCount guests)',
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  icon: Icons.style_rounded,
                  label: 'Theme',
                  value: frameTheme,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                CurrencyFormatter.format(package.price),
                style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
