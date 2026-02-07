import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/features/auth/cubit/auth_user_state.dart';
import 'package:substore_app/features/login/presentation/login_page.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';

import '../../../helpers/helpers.dart';

class MockAuthUserCubit extends MockCubit<AuthUserState> implements AuthUserCubit {}

final getIt = GetIt.I;

void main() {
  late MockAuthUserCubit mockAuthUserCubit;

  setUp(() {
    mockAuthUserCubit = MockAuthUserCubit();
    getIt.registerFactory<AuthUserCubit>(() => mockAuthUserCubit);
  });

  tearDown(() {
    getIt.unregister<AuthUserCubit>();
  });

  Future<void> createLoginPage(WidgetTester tester) async => tester.pumpApp(const LoginPage());

  group('LoginPage', () {
    testWidgets('should render all widgets', (tester) async {
      when(() => mockAuthUserCubit.state).thenAnswer((_) => const AuthUserStateInitial());
      await createLoginPage(tester);

      expect(find.text(AppStrings.login.login), findsOneWidget);
      expect(find.text(AppStrings.login.email), findsOneWidget);
      expect(find.text(AppStrings.login.password), findsOneWidget);
      expect(find.text(AppStrings.login.loginButton), findsOneWidget);
    });

    testWidgets('should disable button when fields are empty', (tester) async {
      when(() => mockAuthUserCubit.state).thenAnswer((_) => const AuthUserStateInitial());
      await createLoginPage(tester);

      final XPrimaryButton loginButton = tester.widget(find.byType(XPrimaryButton));
      expect(loginButton.onPressed, isNull);
    });

    testWidgets('should enable button when both fields have text', (tester) async {
      when(() => mockAuthUserCubit.state).thenAnswer((_) => const AuthUserStateInitial());
      await createLoginPage(tester);

      final emailField = find.byType(TextField).first;
      final passwordField = find.byType(TextField).last;

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'Test@123');
      await tester.pump();

      final XPrimaryButton loginButton = tester.widget(find.byType(XPrimaryButton));
      expect(loginButton.onPressed, isNotNull);
    });

    testWidgets('should call login on button press with valid credentials', (tester) async {
      const String email = 'test@example.com';
      const String password = 'Test@123';
      when(() => mockAuthUserCubit.state).thenAnswer((_) => const AuthUserStateLoginLoading());
      when(() => mockAuthUserCubit.login(email: email, password: password)).thenAnswer((_) => Future.value());

      await createLoginPage(tester);

      final emailField = find.byType(TextField).first;
      final passwordField = find.byType(TextField).last;

      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);
      await tester.pump();

      final loginButton = find.text(AppStrings.login.loginButton);
      await tester.tap(loginButton);
      await tester.pump();

      expect(mockAuthUserCubit.state, isA<AuthUserStateLoginLoading>());
      verify(() => mockAuthUserCubit.login(email: email, password: password)).called(1);
    });

    testWidgets('should show error message when state is AuthUserStateLoginInvalid', (tester) async {
      const String email = 'test@example.com';
      const String password = 'Test@123';
      when(() => mockAuthUserCubit.state).thenAnswer((_) => const AuthUserStateLoginInvalid('Email ou Senha incorretos. Tente novamente'));
      when(() => mockAuthUserCubit.login(email: email, password: password)).thenAnswer((_) => Future.value());

      await createLoginPage(tester);
      await tester.pump();

      expect(find.text('Email ou Senha incorretos. Tente novamente'), findsOneWidget);
    });
  });
}
