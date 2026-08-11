class PackageModel {
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final int durationHours;
  final List<String> features;
  final String category;
  final String imageUrl;
  final String description;
  final bool isFeatured;

  PackageModel({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.durationHours,
    required this.features,
    required this.category,
    required this.imageUrl,
    required this.description,
    this.isFeatured = false,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['original_price'] != null
          ? (json['original_price'] as num).toDouble()
          : null,
      durationHours: json['duration_hours'] as int,
      features: List<String>.from(json['features'] ?? []),
      category: json['category'] as String,
      imageUrl: json['image_url'] as String,
      description: json['description'] as String,
      isFeatured: json['is_featured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'original_price': originalPrice,
      'duration_hours': durationHours,
      'features': features,
      'category': category,
      'image_url': imageUrl,
      'description': description,
      'is_featured': isFeatured,
    };
  }
}
