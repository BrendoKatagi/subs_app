import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:substore_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:substore_app/features/auth/data/models/auth_response_model.dart';
import 'package:substore_app/features/auth/data/models/refresh_token_response_model.dart';
import 'package:substore_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';
import 'package:substore_app/shared/storage/secure_storage.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  late AuthRepositoryImpl authRepository;
  late MockAuthRemoteDatasource mockRemoteDatasource;
  late MockSecureStorage mockSecureStorage;

  const String userSecureStorageKey = 'user_key';

  final DateTime tokenExpiration = DateTime.now().add(const Duration(hours: 1));

  final User testUser = User(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    token: 'test_token',
    refreshToken: 'test_refresh_token',
    tokenExpiration: tokenExpiration,
  );

  final AuthResponseModel testAuthResponseModel = AuthResponseModel(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    token: 'test_token',
    refreshToken: 'test_refresh_token',
    tokenExpiration: tokenExpiration,
  );

  setUp(() {
    mockRemoteDatasource = MockAuthRemoteDatasource();
    mockSecureStorage = MockSecureStorage();
    authRepository = AuthRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      secureStorage: mockSecureStorage,
      userSecureStorageKey: userSecureStorageKey,
    );
    when(() => mockSecureStorage.write(key: any(named: 'key'), value: any(named: 'value'))).thenAnswer((_) async {});
  });

  group('AuthRepositoryImpl - login', () {
    test(
      'should login successfully and save user to secure storage',
      () async {
        when(() => mockRemoteDatasource.login(email: 'test@example.com', password: 'password')).thenAnswer((_) async => testUser);

        final result = await authRepository.login(
          email: 'test@example.com',
          password: 'password',
        );

        expect(result, equals(testUser));
        verify(() => mockRemoteDatasource.login(email: 'test@example.com', password: 'password')).called(1);
        verify(() => mockSecureStorage.write(
              key: userSecureStorageKey,
              value: jsonEncode(testAuthResponseModel.toJson()),
            )).called(1);
      },
    );

    test(
      'should return null when login fails and not save to secure storage',
      () async {
        when(() => mockRemoteDatasource.login(email: 'test@example.com', password: 'wrong_password')).thenAnswer((_) async => null);

        final result = await authRepository.login(
          email: 'test@example.com',
          password: 'wrong_password',
        );

        expect(result, isNull);
        verify(() => mockRemoteDatasource.login(email: 'test@example.com', password: 'wrong_password')).called(1);
        verifyNever(() => mockSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            ));
      },
    );
  });

  group('AuthRepositoryImpl - getUserLogged', () {
    test(
      'should return user when data exists in secure storage',
      () async {
        final userJson = jsonEncode(testAuthResponseModel.toJson());
        when(() => mockSecureStorage.read(key: userSecureStorageKey)).thenAnswer((_) async => userJson);

        final result = await authRepository.getUserLogged();

        expect(result, equals(testUser));
        verify(() => mockSecureStorage.read(key: userSecureStorageKey)).called(1);
      },
    );

    test(
      'should return null when no user data in secure storage',
      () async {
        when(() => mockSecureStorage.read(key: userSecureStorageKey)).thenAnswer((_) async => null);

        final result = await authRepository.getUserLogged();

        expect(result, isNull);
        verify(() => mockSecureStorage.read(key: userSecureStorageKey)).called(1);
      },
    );
  });

  group('AuthRepositoryImpl - refreshToken', () {
    test(
      'should refresh token and update secure storage when user exists',
      () async {
        final userJson = jsonEncode(testAuthResponseModel.toJson());
        const refreshResponse = RefreshTokenResponseModel(
          token: 'new_token',
          refreshToken: 'new_refresh_token',
        );

        when(() => mockSecureStorage.read(key: userSecureStorageKey)).thenAnswer((_) async => userJson);
        when(() => mockRemoteDatasource.refreshToken(refreshToken: 'test_refresh_token')).thenAnswer((_) async => refreshResponse);

        final result = await authRepository.refreshToken(refreshToken: 'test_refresh_token');

        expect(result, equals(refreshResponse));
        verify(() => mockRemoteDatasource.refreshToken(refreshToken: 'test_refresh_token')).called(1);
        verify(() => mockSecureStorage.read(key: userSecureStorageKey)).called(1);

        final updatedAuthModel = testAuthResponseModel.copyWith(
          token: 'new_token',
          refreshToken: 'new_refresh_token',
        );
        verify(() => mockSecureStorage.write(
              key: userSecureStorageKey,
              value: jsonEncode(updatedAuthModel.toJson()),
            )).called(1);
      },
    );

    test(
      'should refresh token even when no user in secure storage',
      () async {
        when(() => mockSecureStorage.read(key: userSecureStorageKey)).thenAnswer((_) async => null);
        const refreshResponse = RefreshTokenResponseModel(
          token: 'new_token',
          refreshToken: 'new_refresh_token',
        );
        when(() => mockRemoteDatasource.refreshToken(refreshToken: 'test_refresh_token')).thenAnswer((_) async => refreshResponse);

        final result = await authRepository.refreshToken(refreshToken: 'test_refresh_token');

        expect(result, equals(refreshResponse));
        verify(() => mockRemoteDatasource.refreshToken(refreshToken: 'test_refresh_token')).called(1);
        verify(() => mockSecureStorage.read(key: userSecureStorageKey)).called(1);
        verifyNever(() => mockSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            ));
      },
    );
  });

  group('AuthRepositoryImpl - resetPassword', () {
    test(
      'should call remote datasource resetPassword',
      () async {
        when(() => mockRemoteDatasource.resetPassword(email: 'test@example.com', link: 'https://reset.link')).thenAnswer((_) async => {});

        await authRepository.resetPassword(email: 'test@example.com', link: 'https://reset.link');

        verify(() => mockRemoteDatasource.resetPassword(email: 'test@example.com', link: 'https://reset.link')).called(1);
      },
    );
  });

  group('AuthRepositoryImpl - updatePassword', () {
    test(
      'should call remote datasource updatePassword and return true',
      () async {
        when(() => mockRemoteDatasource.updatePassword(password: 'new_password', resetToken: 'reset_token')).thenAnswer((_) async => true);

        final result = await authRepository.updatePassword(
          password: 'new_password',
          resetToken: 'reset_token',
        );

        expect(result, isTrue);
        verify(() => mockRemoteDatasource.updatePassword(password: 'new_password', resetToken: 'reset_token')).called(1);
      },
    );

    test(
      'should call remote datasource updatePassword and return false',
      () async {
        when(() => mockRemoteDatasource.updatePassword(password: 'weak_password', resetToken: 'reset_token')).thenAnswer((_) async => false);

        final result = await authRepository.updatePassword(
          password: 'weak_password',
          resetToken: 'reset_token',
        );

        expect(result, isFalse);
        verify(() => mockRemoteDatasource.updatePassword(password: 'weak_password', resetToken: 'reset_token')).called(1);
      },
    );
  });
}
