import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/currency_formatter.dart';
import '../../providers/booking_provider.dart';
import '../../providers/package_provider.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/layout/app_top_bar.dart';

class PackageDetailScreen extends StatelessWidget {
  const PackageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final packageProvider = context.watch<PackageProvider>();
    final package = packageProvider.selectedPackage;

    if (package == null) {
      return const Scaffold(
        body: Center(child: Text('No package selected')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(title: 'Package Details'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Image Banner
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        package.imageUrl,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          height: 220,
                          color: AppColors.primaryLight,
                          child: const Center(
                            child: Icon(Icons.camera_alt_rounded,
                                size: 50, color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Badges & Name
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            package.category.toUpperCase(),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.successLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${package.durationHours} HOURS SERVICE',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Text(
                      package.name,
                      style: AppTextStyles.headingLarge,
                    ),
                    const SizedBox(height: 8),

                    // Price section
                    Row(
                      children: [
                        Text(
                          CurrencyFormatter.format(package.price),
                          style: AppTextStyles.headingLarge.copyWith(
                            color: AppColors.primary,
                            fontSize: 28,
                          ),
                        ),
                        if (package.originalPrice != null) ...[
                          const SizedBox(width: 12),
                          Text(
                            CurrencyFormatter.format(package.originalPrice!),
                            style: AppTextStyles.bodyLarge.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description
                    Text(
                      'Overview',
                      style: AppTextStyles.headingSmall,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      package.description,
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 20),

                    // Included Features Checklist Card
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What\'s Included',
                            style: AppTextStyles.headingSmall,
                          ),
                          const Divider(height: 20, color: AppColors.border),
                          ...package.features.map(
                            (feat) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryLight,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.check_rounded,
                                        size: 14, color: AppColors.primary),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      feat,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Action Buttons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Preview Frames',
                      type: AppButtonType.outline,
                      onPressed: () {
                        final bookingProvider = context.read<BookingProvider>();
                        bookingProvider.startNewBooking(package);
                        Navigator.pushNamed(context, AppRoutes.customizeDesign);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      text: 'Book Now',
                      onPressed: () {
                        final bookingProvider = context.read<BookingProvider>();
                        bookingProvider.startNewBooking(package);
                        Navigator.pushNamed(context, AppRoutes.secureDate);
                      },
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
