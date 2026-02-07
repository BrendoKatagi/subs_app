import 'package:substore_app/features/auth/data/models/refresh_token_response_model.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> login({required String email, required String password});
  Future<User?> getUserLogged();
  Future<RefreshTokenResponseModel> refreshToken({required String refreshToken});
  Future<void> resetPassword({required String email, required String link});
  Future<bool> updatePassword({required String password, required String resetToken});
}
