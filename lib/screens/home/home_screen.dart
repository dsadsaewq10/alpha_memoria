import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/date_formatter.dart';
import '../../providers/auth_provider.dart';
import '../../providers/booking_provider.dart';
import '../../providers/package_provider.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/app_avatar.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/home/home_search_bar.dart';
import '../../widgets/home/package_card.dart';
import '../../widgets/home/trending_designs_grid.dart';

class HomeScreen extends StatelessWidget {
  final Function(int tabIndex)? onNavigateTab;

  const HomeScreen({
    super.key,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final packageProvider = context.watch<PackageProvider>();
    final bookingProvider = context.watch<BookingProvider>();

    final user = authProvider.user;
    final userName = user != null ? user.firstName : 'Juanita';
    final upcomingBooking = bookingProvider.upcomingBooking;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Greeting Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AppAvatar(name: userName, imageUrl: user?.avatarUrl, radius: 22),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, $userName!',
                            style: AppTextStyles.headingSmall,
                          ),
                          Text(
                            'Ready to capture some magic today?',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.notifications_outlined,
                              color: AppColors.textPrimary, size: 20),
                        ),
                        Positioned(
                          right: 2,
                          top: 2,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () => onNavigateTab?.call(2),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Upcoming Event Card (if available)
              if (upcomingBooking != null) ...[
                AppCard(
                  backgroundColor: AppColors.primarySubtle,
                  border: const BorderSide(color: AppColors.primaryLight, width: 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'NEXT EVENT • ${DateFormatter.formatRelativeDays(upcomingBooking.date)}',
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          StatusBadge(status: upcomingBooking.status),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        upcomingBooking.eventType,
                        style: AppTextStyles.headingSmall,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded,
                              size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Text(
                            '${DateFormatter.formatShortDate(upcomingBooking.date)} • ${upcomingBooking.venueLocation}',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () => onNavigateTab?.call(1),
                          icon: const Icon(Icons.arrow_forward_rounded,
                              size: 16, color: AppColors.primary),
                          label: Text(
                            'View Details',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Search Bar
              const HomeSearchBar(),
              const SizedBox(height: 20),

              // Package Categories Horizontal Filter
              SizedBox(
                height: 38,
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
                      backgroundColor: Colors.white,
                      labelStyle: AppTextStyles.caption.copyWith(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
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
              const SizedBox(height: 20),

              // Featured Packages List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured Packages', style: AppTextStyles.headingSmall),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              if (packageProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ...packageProvider.packages.map((pkg) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: PackageCard(
                        package: pkg,
                        onTap: () {
                          packageProvider.setSelectedPackageDirectly(pkg);
                          Navigator.pushNamed(context, AppRoutes.packageDetail);
                        },
                        onBookNow: () {
                          bookingProvider.startNewBooking(pkg);
                          onNavigateTab?.call(1);
                        },
                      ),
                    )),

              const SizedBox(height: 12),

              // Trending Designs Grid
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trending Designs', style: AppTextStyles.headingSmall),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TrendingDesignsGrid(
                designs: packageProvider.trendingDesigns,
                onDesignTap: (title) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected theme: $title')),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
