import '../../models/package_model.dart';

abstract class PackageRepository {
  Future<List<PackageModel>> getPackages({String? category});
  Future<PackageModel?> getPackageById(String id);
  Future<List<Map<String, String>>> getTrendingDesigns();
}
