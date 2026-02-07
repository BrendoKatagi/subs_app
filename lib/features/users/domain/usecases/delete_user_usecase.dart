import 'package:substore_app/features/users/domain/repositories/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository userRepository;

  DeleteUserUseCase({required this.userRepository});

  Future<void> call({required String userId}) async => userRepository.delete(userId: userId);
}
