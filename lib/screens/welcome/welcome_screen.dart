import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/common/app_button.dart';

class PhotoSample {
  final String image;
  final String badge;
  final String title;
  final String subtitle;
  final String category;

  const PhotoSample({
    required this.image,
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.category,
  });
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentImage = 0;
  String _selectedCategory = 'All Formats';

  // TODO: edit these to match your actual categories
  final List<String> _categories = const [
    'All Formats',
    'Classic 2x6 Strips',
    'Magic Mirror Kiosk',
    'Party Props',
    '4x6 Collages',
  ];

  // TODO: edit badge/title/subtitle/category to match what's actually in each photo
  final List<PhotoSample> _samplePhotos = const [
    PhotoSample(
      image: 'assets/images/image 1.png',
      badge: '2x6 Strip',
      title: 'Baby Shower Strip',
      subtitle: 'Blue Pastel Theme',
      category: 'Classic 2x6 Strips',
    ),
    PhotoSample(
      image: 'assets/images/image 2.png',
      badge: '4-Pose Grid',
      title: 'Couples Fellowship',
      subtitle: 'Classic Indigo Border',
      category: '4x6 Collages',
    ),
    PhotoSample(
      image: 'assets/images/image 3.jpg',
      badge: 'Props Station',
      title: 'Fun Party Props',
      subtitle: 'Headbands & Hats',
      category: 'Party Props',
    ),
    PhotoSample(
      image: 'assets/images/image 4.jpg',
      badge: 'Custom Signs',
      title: 'King & Queen Boards',
      subtitle: 'Printed Acrylic Signs',
      category: 'Party Props',
    ),
    PhotoSample(
      image: 'assets/images/image 5.jpg',
      badge: 'Interactive',
      title: 'Magic Mirror Booth',
      subtitle: 'LED Touchscreen',
      category: 'Magic Mirror Kiosk',
    ),
    PhotoSample(
      image: 'assets/images/image 6.jpg',
      badge: 'VIP Staging',
      title: 'Red Carpet Entrance',
      subtitle: 'Golden Stanchions',
      category: 'Magic Mirror Kiosk',
    ),
  ];

  List<PhotoSample> get _filteredPhotos {
    if (_selectedCategory == 'All Formats') return _samplePhotos;
    return _samplePhotos.where((p) => p.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 700;
    final double heroHeight = isMobile ? 280 : 480;
    final double heroTitleSize = isMobile ? 22 : 40;
    final double heroPadding = isMobile ? 20 : 32;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.camera_rounded, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppConstants.appName,
                              style: AppTextStyles.headingSmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                              child: Text(
                                'Login',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              child: const Text('Register', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Hero carousel
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: heroHeight,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              onPageChanged: (index, reason) {
                                setState(() => _currentImage = index);
                              },
                            ),
                            items: [
                              'assets/images/wedding.jpg',
                              'assets/images/birthday.jpg',
                              'assets/images/reunion.jpg',
                            ].map((path) {
                              return Image.asset(
                                path,
                                height: heroHeight,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            }).toList(),
                          ),
                          Container(
                            height: heroHeight,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.75),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(heroPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    'CAPTURE THE JOY',
                                    style: AppTextStyles.caption.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  AppConstants.appTagline,
                                  style: AppTextStyles.headingLarge.copyWith(
                                    color: Colors.white,
                                    fontSize: heroTitleSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 24,
                            right: 24,
                            child: Row(
                              children: List.generate(3, (i) {
                                return Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(_currentImage == i ? 1.0 : 0.4),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Title & Description
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'Welcome to ${AppConstants.appName}',
                            style: AppTextStyles.headingMedium.copyWith(fontSize: isMobile ? 22 : 32),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppConstants.appDescription,
                            style: AppTextStyles.bodyMedium.copyWith(fontSize: 16, color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Sample Photos header + filters
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 12,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sample Photos',
                              style: AppTextStyles.headingSmall.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Live Previews',
                                style: AppTextStyles.caption.copyWith(color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _categories.map((category) {
                            final bool selected = category == _selectedCategory;
                            return ChoiceChip(
                              label: Text(category),
                              selected: selected,
                              onSelected: (_) => setState(() => _selectedCategory = category),
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: selected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Photo grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const spacing = 16.0;
                        final int columns = (constraints.maxWidth / 220).floor().clamp(2, 6);
                        final double cardWidth =
                            (constraints.maxWidth - spacing * (columns - 1)) / columns;
                        return Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children: _filteredPhotos.map((photo) {
                            return SizedBox(
                              width: cardWidth,
                              child: _buildPhotoCard(photo),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 40),

                    // Get Started CTA Button
                    AppButton(
                      text: 'Get Started',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.mainNav),
                    ),
                    const SizedBox(height: 28),

                    // Feature Highlights Row
                    Center(
                      child: Wrap(
                        spacing: 32,
                        runSpacing: 12,
                        children: [
                          _buildFeatureItem(Icons.auto_awesome_rounded, 'Preview'),
                          _buildFeatureItem(Icons.print_rounded, 'Instant Prints'),
                          _buildFeatureItem(Icons.photo_library_rounded, 'Digital Gallery'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    Center(
                      child: Text(
                        '© 2026 Alpha Memoria. All rights reserved.',
                        style: AppTextStyles.caption.copyWith(color: Colors.grey[500]),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoCard(PhotoSample photo) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    photo.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    photo.badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  photo.title,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  photo.subtitle,
                  style: AppTextStyles.caption.copyWith(color: Colors.grey[500], fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}