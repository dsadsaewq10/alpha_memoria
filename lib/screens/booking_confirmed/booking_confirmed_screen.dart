import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/date_formatter.dart';
import '../../models/booking_model.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/status_badge.dart';

class BookingConfirmedScreen extends StatelessWidget {
  final BookingModel? booking;

  const BookingConfirmedScreen({
    super.key,
    this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final activeBooking = booking ?? bookingProvider.lastConfirmedBooking ?? bookingProvider.upcomingBooking;

    final refCode = activeBooking?.referenceCode ?? '#AM-89412';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Success Animated Circle Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primarySubtle,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 56),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Booking Confirmed',
                style: AppTextStyles.headingLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Your booking has been received and is being processed.',
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Ref Code Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Ref: $refCode',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Booking Details Recap Card
              if (activeBooking != null)
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(activeBooking.packageName, style: AppTextStyles.headingSmall),
                          StatusBadge(status: activeBooking.status),
                        ],
                      ),
                      const Divider(height: 20, color: AppColors.border),
                      _buildInfoRow(Icons.calendar_today_rounded, 'Date & Time',
                          '${DateFormatter.formatShortDate(activeBooking.date)} • ${activeBooking.timeSlot}'),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.location_on_rounded, 'Location', activeBooking.venueLocation),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.style_rounded, 'Custom Theme', activeBooking.frameTheme),
                    ],
                  ),
                ),
              const SizedBox(height: 24),

              // What Happens Next Card
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('What Happens Next?', style: AppTextStyles.headingSmall),
                    const SizedBox(height: 14),
                    _buildCheckstep(
                      num: '1',
                      title: 'Payment Verification',
                      desc: 'Our team will verify your payment receipt within 24 hours.',
                    ),
                    const SizedBox(height: 12),
                    _buildCheckstep(
                      num: '2',
                      title: 'Booth Setup',
                      desc: 'Our technical crew arrives 2 hours before your event start time.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              AppButton(
                text: 'View All Bookings',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.mainNav,
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'Back to Home',
                type: AppButtonType.outline,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.mainNav,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String val) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Text('$title: ', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
        Expanded(child: Text(val, style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _buildCheckstep({required String num, required String title, required String desc}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(num, style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              Text(desc, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }
}
