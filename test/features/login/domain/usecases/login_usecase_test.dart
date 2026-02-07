import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:substore_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:substore_app/features/login/domain/usecases/login_usecase.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUsecase loginUsecase;
  late MockAuthRepository mockAuthRepository;

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
    mockAuthRepository = MockAuthRepository();
    loginUsecase = LoginUsecaseImpl(mockAuthRepository);
  });

  group('LoginUsecaseImpl', () {
    test(
      'should call authRepository login with correct parameters',
      () async {
        when(() => mockAuthRepository.login(email: 'test@example.com', password: 'password')).thenAnswer((_) async => testUser);

        final result = await loginUsecase(email: 'test@example.com', password: 'password');

        expect(result, equals(testUser));
        verify(() => mockAuthRepository.login(email: 'test@example.com', password: 'password')).called(1);
      },
    );

    test(
      'should return null when authRepository returns null',
      () async {
        when(() => mockAuthRepository.login(email: 'invalid@example.com', password: 'wrong_password')).thenAnswer((_) async => null);

        final result = await loginUsecase(email: 'invalid@example.com', password: 'wrong_password');

        expect(result, isNull);
        verify(() => mockAuthRepository.login(email: 'invalid@example.com', password: 'wrong_password')).called(1);
      },
    );

    test(
      'should propagate exception when authRepository throws',
      () async {
        when(() => mockAuthRepository.login(email: 'test@example.com', password: 'password')).thenThrow(Exception('Network error'));

        expect(
          () => loginUsecase(email: 'test@example.com', password: 'password'),
          throwsA(isA<Exception>()),
        );
        verify(() => mockAuthRepository.login(email: 'test@example.com', password: 'password')).called(1);
      },
    );
  });
}
