import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/package_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/package_provider.dart';
import '../../widgets/booking/booking_stepper.dart';
import '../../widgets/layout/app_top_bar.dart';

class SelectPackageScreen extends StatelessWidget {
  final bool showBackButton;

  const SelectPackageScreen({
    super.key,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.read<BookingProvider>();
    final packageProvider = context.read<PackageProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppTopBar(
        title: 'Alpha Memoria',
        showBackButton: showBackButton,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // STEP 1 OF 4: Select Package
            const BookingStepper(
              currentStep: 1,
              totalSteps: 4,
              stepTitle: 'Select Package',
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 650;

                  final card1 = _buildPackageCard(
                    context: context,
                    imageAsset: 'assets/images/image 1.png',
                    name: 'Package 1',
                    price: '₱9,500',
                    features: const [
                      '2 hours of rent',
                      'Magic Mirror Kiosk',
                      'Party Props',
                    ],
                    onBookNow: () {
                      final pkg = PackageModel(
                        id: 'pkg_1',
                        name: 'Package 1',
                        price: 9500,
                        durationHours: 2,
                        features: [
                          '2 hours of rent',
                          'Magic Mirror Kiosk',
                          'Party Props',
                        ],
                        category: 'All Packages',
                        imageUrl: 'assets/images/image 1.png',
                        description: 'Standard 2-hour photo booth rental with Magic Mirror Kiosk and party props.',
                        isFeatured: true,
                      );
                      packageProvider.setSelectedPackageDirectly(pkg);
                      bookingProvider.startNewBooking(pkg);
                      Navigator.pushNamed(context, AppRoutes.secureDate);
                    },
                  );

                  final card2 = _buildPackageCard(
                    context: context,
                    imageAsset: 'assets/images/image 2.png',
                    name: 'Package 2',
                    price: '₱12,500',
                    features: const [
                      '3 hours of rent',
                      'Magic Mirror Kiosk',
                      'Party Props',
                    ],
                    onBookNow: () {
                      final pkg = PackageModel(
                        id: 'pkg_2',
                        name: 'Package 2',
                        price: 12500,
                        durationHours: 3,
                        features: [
                          '3 hours of rent',
                          'Magic Mirror Kiosk',
                          'Party Props',
                        ],
                        category: 'All Packages',
                        imageUrl: 'assets/images/image 2.png',
                        description: 'Deluxe 3-hour photo booth rental with Magic Mirror Kiosk and party props.',
                        isFeatured: true,
                      );
                      packageProvider.setSelectedPackageDirectly(pkg);
                      bookingProvider.startNewBooking(pkg);
                      Navigator.pushNamed(context, AppRoutes.secureDate);
                    },
                  );

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 860),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: card1),
                                  const SizedBox(width: 20),
                                  Expanded(child: card2),
                                ],
                              )
                            : Column(
                                children: [
                                  card1,
                                  const SizedBox(height: 20),
                                  card2,
                                  const SizedBox(height: 24),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard({
    required BuildContext context,
    required String imageAsset,
    required String name,
    required String price,
    required List<String> features,
    required VoidCallback onBookNow,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Package Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Container(
                  color: const Color(0xFFEDF2F7),
                  child: const Center(
                    child: Icon(Icons.photo_library_outlined, size: 40, color: Color(0xFF94A3B8)),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Name & Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        color: AppColors.primaryNavy,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Feature bullet points
                ...features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 16,
                          color: AppColors.primaryNavy,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          feature,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Book Now button
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onBookNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
