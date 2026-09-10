import '../repositories/auth_repository.dart';
import '../../models/user_model.dart';

class MockAuthRepository implements AuthRepository {
  UserModel? _currentUser = UserModel(
    id: 'jo123',
    firstName: 'Jonathan',
    middleName: 'Pulongbarit',
    lastName: 'Romasanta',
    suffix: '',
    email: 'testing@example.com',
    phone: '+63 123456789',
    birthday: '10/15/1996',
    avatarUrl: '',
  );

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _currentUser = UserModel(
      id: 'jo123',
      firstName: 'Jonathan',
      middleName: 'Pulongbarit',
      lastName: 'Romasanta',
      suffix: '',
      email: email,
      phone: '+63 123456789',
      birthday: '10/15/1996',
    );
    return _currentUser!;
  }

  @override
  Future<UserModel> register({
    required String firstName,
    String? middleName,
    required String lastName,
    String? suffix,
    required String email,
    required String phone,
    required String birthday,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    _currentUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      suffix: suffix,
      email: email,
      phone: phone,
      birthday: birthday,
    );
    return _currentUser!;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock: no actual email is sent, just simulates network latency.
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }
}