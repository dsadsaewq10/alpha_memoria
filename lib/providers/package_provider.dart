import 'package:flutter/foundation.dart';
import '../data/repositories/package_repository.dart';
import '../models/package_model.dart';

class PackageProvider extends ChangeNotifier {
  final PackageRepository _packageRepository;

  List<PackageModel> _packages = [];
  List<Map<String, String>> _trendingDesigns = [];
  String _selectedCategory = 'All Packages';
  bool _isLoading = false;
  PackageModel? _selectedPackage;

  PackageProvider({required PackageRepository packageRepository})
      : _packageRepository = packageRepository {
    loadPackages();
    loadTrendingDesigns();
  }

  List<PackageModel> get packages => _packages;
  List<Map<String, String>> get trendingDesigns => _trendingDesigns;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  PackageModel? get selectedPackage => _selectedPackage;

  Future<void> loadPackages({String? category}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _selectedCategory = category ?? 'All Packages';
      _packages = await _packageRepository.getPackages(category: _selectedCategory);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadTrendingDesigns() async {
    _trendingDesigns = await _packageRepository.getTrendingDesigns();
    notifyListeners();
  }

  Future<void> selectPackage(String packageId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _selectedPackage = await _packageRepository.getPackageById(packageId);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedPackageDirectly(PackageModel package) {
    _selectedPackage = package;
    notifyListeners();
  }
}
