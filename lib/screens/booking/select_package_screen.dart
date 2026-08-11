import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/booking_provider.dart';
import '../../providers/package_provider.dart';
import '../../widgets/booking/booking_stepper.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/layout/app_top_bar.dart';

class SelectPackageScreen extends StatefulWidget {
  const SelectPackageScreen({super.key});

  @override
  State<SelectPackageScreen> createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  @override
  Widget build(BuildContext context) {
    final packageProvider = context.watch<PackageProvider>();
    final bookingProvider = context.watch<BookingProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(
        title: 'Alpha Memoria',
        showBackButton: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Live support chat opened')),
          );
        },
        backgroundColor: const Color(0xFFFF5286),
        child: const Icon(Icons.chat_bubble_rounded, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // STEPPER: STEP 2 OF 6 Select Package
            const BookingStepper(
              currentStep: 2,
              totalSteps: 6,
              stepTitle: 'Select Package',
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF4FD),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        onChanged: (val) {},
                        style: AppTextStyles.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'Search for themes or locations...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.textMuted,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Horizontal Category Chips
                    SizedBox(
                      height: 36,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppConstants.packageCategories.length,
                        separatorBuilder: (ctx, i) => const SizedBox(width: 8),
                        itemBuilder: (ctx, index) {
                          final cat = AppConstants.packageCategories[index];
                          final isSelected = cat == packageProvider.selectedCategory;
                          return ChoiceChip(
                            label: Text(cat),
                            selected: isSelected,
                            selectedColor: AppColors.primary,
                            backgroundColor: const Color(0xFFDDE8F8),
                            labelStyle: AppTextStyles.caption.copyWith(
                              color: isSelected ? Colors.white : AppColors.primaryDark,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                              fontSize: 12,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide.none,
                            ),
                            onSelected: (selected) {
                              if (selected) {
                                packageProvider.loadPackages(category: cat);
                              }
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Package Card 1: Starter Celebration
                    _buildStarterCard(
                      context,
                      onBook: () {
                        final starterPkg = packageProvider.packages.firstWhere(
                          (p) => p.id == 'pkg_starter',
                          orElse: () => packageProvider.packages.first,
                        );
                        bookingProvider.startNewBooking(starterPkg);
                        Navigator.pushNamed(context, AppRoutes.secureDate);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Package Card 2: Ultimate Gala / Premium Experience
                    _buildUltimateGalaCard(
                      context,
                      onSelect: () {
                        final glamPkg = packageProvider.packages.firstWhere(
                          (p) => p.id == 'pkg_glam',
                          orElse: () => packageProvider.packages.first,
                        );
                        bookingProvider.startNewBooking(glamPkg);
                        Navigator.pushNamed(context, AppRoutes.secureDate);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Package Card 3: Eternal Vows Bundle
                    _buildEternalVowsCard(
                      context,
                      onPreview: () {
                        final eternalPkg = packageProvider.packages.firstWhere(
                          (p) => p.id == 'pkg_eternal',
                          orElse: () => packageProvider.packages.first,
                        );
                        bookingProvider.startNewBooking(eternalPkg);
                        Navigator.pushNamed(context, AppRoutes.customizeDesign);
                      },
                      onBook: () {
                        final eternalPkg = packageProvider.packages.firstWhere(
                          (p) => p.id == 'pkg_eternal',
                          orElse: () => packageProvider.packages.first,
                        );
                        bookingProvider.startNewBooking(eternalPkg);
                        Navigator.pushNamed(context, AppRoutes.secureDate);
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarterCard(BuildContext context, {required VoidCallback onBook}) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  'https://images.unsplash.com/photo-1511795409834-ef04bbd61622',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    height: 160,
                    color: AppColors.primaryLight,
                    child: const Icon(Icons.camera_alt_rounded, size: 40, color: AppColors.primary),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '₱199 / Event',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Starter Celebration',
                      style: AppTextStyles.headingSmall.copyWith(fontSize: 18),
                    ),
                    const Icon(Icons.favorite_border_rounded, color: AppColors.textMuted, size: 22),
                  ],
                ),
                const SizedBox(height: 10),
                _buildCheckItem('2 Hours Runtime'),
                const SizedBox(height: 6),
                _buildCheckItem('Digital Delivery via Email/SMS'),
                const SizedBox(height: 6),
                _buildCheckItem('Standard Backdrop'),
                const SizedBox(height: 16),
                AppButton(
                  text: 'Book Now',
                  onPressed: onBook,
                  height: 44,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, color: AppColors.primary, size: 14),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildUltimateGalaCard(BuildContext context, {required VoidCallback onSelect}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.network(
                  'https://images.unsplash.com/photo-1492684223066-81342ee5ff30',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    height: 200,
                    color: AppColors.primaryDark,
                    child: const Icon(Icons.star_rounded, size: 48, color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.85),
                    ],
                  ),
                ),
              ),
              // Top Ribbon Badge
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD81B60),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                  ),
                  child: Text(
                    'Most Popular',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PREMIUM EXPERIENCE',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Ultimate Gala',
                      style: AppTextStyles.headingMedium.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Text(
                    '₱449',
                    style: AppTextStyles.headingSmall.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeatureIcon(Icons.access_time_rounded, '4 Hours'),
                _buildFeatureIcon(Icons.print_rounded, 'Unlimited Prints'),
                _buildFeatureIcon(Icons.people_rounded, 'On-site Attendant'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: AppButton(
              text: 'Book Now',
              onPressed: onSelect,
              height: 44,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildEternalVowsCard(
    BuildContext context, {
    required VoidCallback onPreview,
    required VoidCallback onBook,
  }) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1519741497674-611481863552',
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          height: 170,
                          color: AppColors.primaryLight,
                          child: const Icon(Icons.favorite_rounded, size: 40, color: AppColors.primary),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC2185B),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Wedding Special',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Eternal Vows Bundle',
                      style: AppTextStyles.headingSmall.copyWith(fontSize: 18),
                    ),
                    const Icon(Icons.favorite_rounded, color: Color(0xFFC2185B), size: 22),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Tailored for your special day with elegant floral themes and guest book service.',
                  style: AppTextStyles.bodyMedium.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '₱799',
                      style: AppTextStyles.headingMedium.copyWith(
                        color: AppColors.primary,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '₱950',
                      style: AppTextStyles.bodyMedium.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD81B60), width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                    ),
                    onPressed: onPreview,
                    child: Text(
                      'Preview Frames',
                      style: AppTextStyles.button.copyWith(
                        color: const Color(0xFFD81B60),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
