class UserModel {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? suffix;
  final String email;
  final String phone;
  final String birthday;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.suffix,
    required this.email,
    required this.phone,
    required this.birthday,
    this.avatarUrl,
  });

  String get fullName {
    final parts = [
      firstName,
      if (middleName != null && middleName!.isNotEmpty) middleName,
      lastName,
      if (suffix != null && suffix!.isNotEmpty) suffix,
    ];
    return parts.join(' ');
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String,
      suffix: json['suffix'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String,
      birthday: json['birthday'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'suffix': suffix,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'avatar_url': avatarUrl,
    };
  }
}
