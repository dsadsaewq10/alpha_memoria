import '../repositories/package_repository.dart';
import '../../models/package_model.dart';

class MockPackageRepository implements PackageRepository {
  final List<PackageModel> _mockPackages = [
    PackageModel(
      id: 'pkg_starter',
      name: 'Starter Celebration',
      price: 199,
      originalPrice: 249,
      durationHours: 2,
      features: [
        '2 Hours Photo Booth',
        'Digital Gallery + Instant Downloads',
        'Starter Backdrop Included',
        'Unlimited Digital Captures',
      ],
      category: 'Birthday',
      imageUrl: 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622',
      description:
          'Perfect for small intimate gatherings, birthdays, and anniversaries. Includes high-resolution photo strip downloads and custom digital overlay.',
      isFeatured: true,
    ),
    PackageModel(
      id: 'pkg_glam',
      name: 'Ultimate Glam Experience',
      price: 449,
      originalPrice: 520,
      durationHours: 4,
      features: [
        '4 Hours Unlimited Photo Printing',
        'Glam Filter + Custom Lighting',
        'Custom Monogram / Logo Design',
        'On-site Professional Attendant',
      ],
      category: 'Corporate',
      imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30',
      description:
          'Elevate your brand or special event with studio-grade lighting, live instant printing, custom prop selection, and custom brand frame templates.',
      isFeatured: true,
    ),
    PackageModel(
      id: 'pkg_eternal',
      name: 'Eternal Vows Bundle',
      price: 799,
      originalPrice: 950,
      durationHours: 6,
      features: [
        '6 Hours Photo Booth Service',
        'Premium Floral Backdrop',
        'Luxury Leather Guest Album',
        'Unlimited Instant Physical Prints',
        '360 Video Spinner Access',
      ],
      category: 'Wedding',
      imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552',
      description:
          'Tailored specially for weddings! Create unforgettable memories with custom guest book assembly, premium floral booth backdrops, and video clips.',
      isFeatured: true,
    ),
  ];

  final List<Map<String, String>> _mockTrendingDesigns = [
    {
      'id': 'des_1',
      'title': 'Elegant Floral',
      'category': 'Wedding',
      'imageUrl': 'https://images.unsplash.com/photo-1520854221256-17451cc331bf',
    },
    {
      'id': 'des_2',
      'title': 'Neon Nights',
      'category': 'Corporate',
      'imageUrl': 'https://images.unsplash.com/photo-1508997449629-303059a039c0',
    },
    {
      'id': 'des_3',
      'title': 'Golden Vintage',
      'category': 'Birthday',
      'imageUrl': 'https://images.unsplash.com/photo-1513151233558-d860c5398176',
    },
  ];

  @override
  Future<List<PackageModel>> getPackages({String? category}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (category == null || category == 'All Packages') {
      return _mockPackages;
    }
    return _mockPackages.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
  }

  @override
  Future<PackageModel?> getPackageById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockPackages.firstWhere(
      (p) => p.id == id,
      orElse: () => _mockPackages.first,
    );
  }

  @override
  Future<List<Map<String, String>>> getTrendingDesigns() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockTrendingDesigns;
  }
}
