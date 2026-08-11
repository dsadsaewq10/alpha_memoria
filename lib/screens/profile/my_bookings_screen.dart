import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/booking_model.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/layout/app_top_bar.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  int _selectedTab = 0; // 0: Upcoming, 1: Past

  final List<Map<String, dynamic>> _pastBookingsMock = [
    {
      'id': 'past_1',
      'title': 'Grand Anniversary Photo Booth',
      'date': DateTime.now().subtract(const Duration(days: 45)),
      'timeSlot': '05:00 PM - 09:00 PM',
      'status': 'Completed',
      'location': 'Solaire Resort Ballroom A',
      'total': '\$299',
    },
    {
      'id': 'past_2',
      'title': 'Corporate Gala 2025 Package',
      'date': DateTime.now().subtract(const Duration(days: 120)),
      'timeSlot': '06:00 PM - 11:00 PM',
      'status': 'Completed',
      'location': 'Shangri-La Fort Hall 3',
      'total': '\$450',
    },
    {
      'id': 'past_3',
      'title': 'Birthday Celebration Starter',
      'date': DateTime.now().subtract(const Duration(days: 210)),
      'timeSlot': '01:00 PM - 04:00 PM',
      'status': 'Completed',
      'location': 'BGC High Street Pavilion',
      'total': '\$199',
    },
  ];

  void _confirmCancelBooking(BuildContext context, String title, String? bookingId) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Cancel Booking', style: AppTextStyles.headingSmall),
        content: Text(
          'Are you sure you want to cancel "$title"? This action cannot be undone.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text('Keep Booking', style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              final provider = context.read<BookingProvider>();
              Navigator.pop(dialogCtx);
              if (bookingId != null) {
                await provider.cancelBooking(bookingId);
              }
              messenger.showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.info_outline_rounded, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Booking cancelled successfully.'),
                    ],
                  ),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Text('Confirm Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showBookingDetails({
    required String title,
    required String dateStr,
    required String timeSlot,
    required String location,
    required String status,
    String? bookingId,
    bool isUpcoming = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderDark,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: status == 'Cancelled'
                        ? AppColors.errorLight
                        : AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: status == 'Cancelled' ? AppColors.error : AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.headingSmall),
                      const SizedBox(height: 2),
                      _buildStatusChip(status),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: AppColors.border),
            const SizedBox(height: 12),
            _buildDetailTile(Icons.access_time_rounded, 'Date & Time', '$dateStr • $timeSlot'),
            const SizedBox(height: 12),
            _buildDetailTile(Icons.location_on_outlined, 'Location', location),
            const SizedBox(height: 24),
            
            // Action Buttons
            if (isUpcoming && status != 'Cancelled') ...[
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _confirmCancelBooking(context, title, bookingId);
                  },
                  icon: const Icon(Icons.cancel_outlined, color: AppColors.error, size: 18),
                  label: Text('Cancel Booking', style: AppTextStyles.button.copyWith(color: AppColors.error)),
                ),
              ),
              const SizedBox(height: 12),
            ],

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () => Navigator.pop(ctx),
                child: Text('Close Details', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg = AppColors.infoLight;
    Color fg = AppColors.primary;
    if (status == 'Completed') {
      bg = AppColors.successLight;
      fg = AppColors.success;
    } else if (status == 'Cancelled') {
      bg = AppColors.errorLight;
      fg = AppColors.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: AppTextStyles.caption.copyWith(
          color: fg,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
            Text(subtitle, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final upcomingBookings = bookingProvider.bookings;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(title: 'My Bookings'),
      body: SafeArea(
        child: Column(
          children: [
            // Top Tab Navigation Bar (Underline indicator)
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
              ),
              child: Row(
                children: [
                  Expanded(child: _buildTabButton('Upcoming', 0)),
                  Expanded(child: _buildTabButton('Past', 1)),
                ],
              ),
            ),
            Expanded(
              child: _selectedTab == 0
                  ? _buildUpcomingList(upcomingBookings)
                  : _buildPastList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isActive = _selectedTab == index;
    return InkWell(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingList(List<BookingModel> bookings) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.calendar_today_outlined, size: 40, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text('No Upcoming Bookings', style: AppTextStyles.headingSmall),
            const SizedBox(height: 6),
            Text(
              'Your booked celebrations will appear here',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: bookings.length,
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),
      itemBuilder: (context, index) {
        final b = bookings[index];
        final title = '${b.packageName} - ${b.eventType}';
        final dateStr = DateFormat('MMM dd, yyyy').format(b.date);
        final timeStr = b.timeSlot;

        return _buildBookingRow(
          title: title,
          dateTimeStr: '$dateStr • $timeStr',
          status: b.status,
          isUpcoming: true,
          onTap: () => _showBookingDetails(
            title: title,
            dateStr: dateStr,
            timeSlot: b.timeSlot,
            location: b.venueLocation,
            status: b.status,
            bookingId: b.id,
            isUpcoming: true,
          ),
          onCancel: b.status != 'Cancelled'
              ? () => _confirmCancelBooking(context, title, b.id)
              : null,
        );
      },
    );
  }

  Widget _buildPastList() {
    return ListView.separated(
      itemCount: _pastBookingsMock.length,
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),
      itemBuilder: (context, index) {
        final item = _pastBookingsMock[index];
        final dateStr = DateFormat('MMM dd, yyyy').format(item['date'] as DateTime);
        final title = item['title'] as String;
        final timeSlot = item['timeSlot'] as String;
        final location = item['location'] as String;
        final status = item['status'] as String;

        return _buildBookingRow(
          title: title,
          dateTimeStr: '$dateStr • $timeSlot',
          status: status,
          isUpcoming: false,
          onTap: () => _showBookingDetails(
            title: title,
            dateStr: dateStr,
            timeSlot: timeSlot,
            location: location,
            status: status,
            isUpcoming: false,
          ),
        );
      },
    );
  }

  Widget _buildBookingRow({
    required String title,
    required String dateTimeStr,
    required String status,
    required bool isUpcoming,
    required VoidCallback onTap,
    VoidCallback? onCancel,
  }) {
    final isCancelled = status == 'Cancelled';

    return InkWell(
      onTap: onTap,
      highlightColor: AppColors.primarySubtle,
      splashColor: AppColors.primaryLight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isCancelled ? AppColors.errorLight : AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.calendar_month_rounded,
                color: isCancelled ? AppColors.error : AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isCancelled ? AppColors.textMuted : AppColors.textPrimary,
                      decoration: isCancelled ? TextDecoration.lineThrough : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        dateTimeStr,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (isCancelled) ...[
                        const SizedBox(width: 8),
                        _buildStatusChip(status),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (isUpcoming && !isCancelled && onCancel != null) ...[
              IconButton(
                icon: const Icon(Icons.cancel_outlined, color: AppColors.error, size: 20),
                tooltip: 'Cancel Booking',
                onPressed: onCancel,
              ),
            ] else ...[
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
                size: 22,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
