import '../../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> login(String email, String password);
  Future<UserModel> register({
    required String firstName,
    String? middleName,
    required String lastName,
    String? suffix,
    required String email,
    required String phone,
    required String birthday,
    required String password,
  });
  Future<void> logout();
}
