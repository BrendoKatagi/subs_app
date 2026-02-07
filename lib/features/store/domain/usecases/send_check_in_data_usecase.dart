import 'package:substore_app/features/store/domain/repositories/check_in_data_repository.dart';

class SendCheckIndDataUseCase {
  final CheckInDataRepository checkInDataRepository;

  SendCheckIndDataUseCase({required this.checkInDataRepository});

  Future<void> call(String checkInData) =>
      checkInDataRepository.sendCheckInData(checkInData);
}
