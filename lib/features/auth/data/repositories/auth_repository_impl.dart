import 'dart:convert';

import 'package:substore_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:substore_app/features/auth/data/models/auth_response_model.dart';
import 'package:substore_app/features/auth/data/models/refresh_token_response_model.dart';
import 'package:substore_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';
import 'package:substore_app/shared/storage/secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final SecureStorage secureStorage;
  final String userSecureStorageKey;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.secureStorage,
    required this.userSecureStorageKey,
  });

  @override
  Future<User?> login({required String email, required String password}) async {
    final User? user = await remoteDatasource.login(email: email, password: password);

    if (user != null) {
      await secureStorage.write(
        key: userSecureStorageKey,
        value: jsonEncode(AuthResponseModel.fromEntity(user).toJson()),
      );
    }

    return user;
  }

  @override
  Future<User?> getUserLogged() async {
    final userJson = await secureStorage.read(key: userSecureStorageKey);

    if (userJson != null) {
      return AuthResponseModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>).toEntity();
    }

    return null;
  }

  @override
  Future<RefreshTokenResponseModel> refreshToken({required String refreshToken}) async {
    final RefreshTokenResponseModel result = await remoteDatasource.refreshToken(refreshToken: refreshToken);
    final String? userJson = await secureStorage.read(key: userSecureStorageKey);

    if (userJson != null) {
      final AuthResponseModel authModel = AuthResponseModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>).copyWith(
        token: result.token,
        refreshToken: result.refreshToken,
      );

      await secureStorage.write(
        key: userSecureStorageKey,
        value: jsonEncode(authModel.toJson()),
      );
    }
    return result;
  }

  @override
  Future<void> resetPassword({required String email, required String link}) {
    return remoteDatasource.resetPassword(email: email, link: link);
  }

  @override
  Future<bool> updatePassword({required String password, required String resetToken}) {
    return remoteDatasource.updatePassword(password: password, resetToken: resetToken);
  }
}
