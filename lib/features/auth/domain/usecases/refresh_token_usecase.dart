import 'package:substore_app/features/auth/data/models/refresh_token_response_model.dart';
import 'package:substore_app/features/auth/domain/repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository authRepository;

  RefreshTokenUseCase(this.authRepository);

  Future<RefreshTokenResponseModel> call({required String refreshToken}) =>
      authRepository.refreshToken(refreshToken: refreshToken);
}
