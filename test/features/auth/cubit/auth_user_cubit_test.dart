import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/features/auth/cubit/auth_user_state.dart';
import 'package:substore_app/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:substore_app/features/login/domain/usecases/login_usecase.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';
import 'package:substore_app/shared/storage/secure_storage.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockGetUserLoggedUseCase extends Mock implements GetUserLoggedUseCase {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  late AuthUserCubit authUserCubit;
  late MockLoginUsecase mockLoginUsecase;
  late MockGetUserLoggedUseCase mockGetUserLoggedUseCase;
  late MockSecureStorage mockSecureStorage;

  final DateTime tokenExpiration = DateTime.now().add(const Duration(hours: 1));

  final User testUser = User(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    token: 'test_token',
    refreshToken: 'test_refresh_token',
    tokenExpiration: tokenExpiration,
  );

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    mockGetUserLoggedUseCase = MockGetUserLoggedUseCase();
    mockSecureStorage = MockSecureStorage();
    authUserCubit = AuthUserCubit(
      secureStorage: mockSecureStorage,
      loginUsecase: mockLoginUsecase,
      getUserLoggedUseCase: mockGetUserLoggedUseCase,
    );
  });

  group('AuthUserCubit - validateEmail', () {
    test('should return null for valid email', () {
      final result = authUserCubit.validateEmail('test@example.com');
      expect(result, isNull);
    });

    test('should return error for invalid email', () {
      final result = authUserCubit.validateEmail('invalid-email');
      expect(result, isNotNull);
    });
  });

  group('AuthUserCubit - validatePassword', () {
    test('should return null for valid password', () {
      final result = authUserCubit.validatePassword('Test@123');
      expect(result, isNull);
    });

    test('should return error for invalid password', () {
      final result = authUserCubit.validatePassword('weak');
      expect(result, isNotNull);
    });
  });

  group('AuthUserCubit - login', () {
    blocTest<AuthUserCubit, AuthUserState>(
      'should emit Loading then Logged on success',
      setUp: () {
        when(() => mockLoginUsecase.call(email: 'test@example.com', password: 'Test@123')).thenAnswer((_) async => testUser);
      },
      build: () => authUserCubit,
      act: (cubit) => cubit.login(email: 'test@example.com', password: 'Test@123'),
      expect: () => [
        const AuthUserStateLoginLoading(),
        AuthUserStateLogged(testUser),
      ],
    );

    blocTest<AuthUserCubit, AuthUserState>(
      'should emit Loading then LoginInvalid when email is invalid',
      build: () => authUserCubit,
      act: (cubit) => cubit.login(email: 'invalid-email', password: 'Valid@123'),
      expect: () => [
        const AuthUserStateLoginLoading(),
        const AuthUserStateLoginInvalid('Email ou Senha incorretos. Tente novamente'),
      ],
    );

    blocTest<AuthUserCubit, AuthUserState>(
      'should emit Loading then LoginInvalid when password is invalid',
      build: () => authUserCubit,
      act: (cubit) => cubit.login(email: 'test@example.com', password: 'weak'),
      expect: () => [
        const AuthUserStateLoginLoading(),
        const AuthUserStateLoginInvalid('Email ou Senha incorretos. Tente novamente'),
      ],
    );

    blocTest<AuthUserCubit, AuthUserState>(
      'should emit Loading then LoginError when user is null',
      setUp: () {
        when(() => mockLoginUsecase.call(email: 'test@example.com', password: 'Test@123')).thenAnswer((_) async => null);
      },
      build: () => authUserCubit,
      act: (cubit) => cubit.login(email: 'test@example.com', password: 'Test@123'),
      expect: () => [
        const AuthUserStateLoginLoading(),
        const AuthUserStateLoginError(),
      ],
    );

    blocTest<AuthUserCubit, AuthUserState>(
      'should emit Loading then LoginError on exception',
      setUp: () {
        when(() => mockLoginUsecase.call(email: 'test@example.com', password: 'Test@123')).thenThrow(Exception('Network error'));
      },
      build: () => authUserCubit,
      act: (cubit) => cubit.login(email: 'test@example.com', password: 'Test@123'),
      expect: () => [
        const AuthUserStateLoginLoading(),
        const AuthUserStateLoginError(),
      ],
    );
  });

  group('AuthUserCubit - getUserLogged', () {
    blocTest<AuthUserCubit, AuthUserState>(
      'should return early if already logged',
      setUp: () {
        when(() => mockGetUserLoggedUseCase.call()).thenAnswer((_) async => testUser);
      },
      build: () => authUserCubit,
      seed: () => AuthUserStateLogged(testUser),
      act: (cubit) => cubit.getUserLogged(),
      expect: () => <dynamic>[],
    );

    blocTest<AuthUserCubit, AuthUserState>(
      'should emit NotLogged when no user found',
      setUp: () {
        when(() => mockGetUserLoggedUseCase.call()).thenAnswer((_) async => null);
      },
      build: () => authUserCubit,
      act: (cubit) => cubit.getUserLogged(),
      expect: () => [
        const AuthUserStateNotLogged(),
      ],
    );

    blocTest<AuthUserCubit, AuthUserState>(
      'should emit Logged when user exists',
      setUp: () {
        when(() => mockGetUserLoggedUseCase.call()).thenAnswer((_) async => testUser);
      },
      build: () => authUserCubit,
      act: (cubit) => cubit.getUserLogged(),
      expect: () => [
        AuthUserStateLogged(testUser),
      ],
    );

    blocTest<AuthUserCubit, AuthUserState>(
      'should emit Failure on exception',
      setUp: () {
        when(() => mockGetUserLoggedUseCase.call()).thenThrow(Exception('Error'));
      },
      build: () => authUserCubit,
      act: (cubit) => cubit.getUserLogged(),
      expect: () => [
        const AuthUserStateFailure(),
      ],
    );
  });

  group('AuthUserCubit - logout', () {
    blocTest<AuthUserCubit, AuthUserState>(
      'should delete storage and emit NotLogged',
      setUp: () {
        when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async {});
      },
      build: () => authUserCubit,
      act: (cubit) => cubit.logout(),
      expect: () => [
        const AuthUserStateNotLogged(),
      ],
      verify: (_) {
        verify(() => mockSecureStorage.deleteAll()).called(1);
      },
    );
  });
}
