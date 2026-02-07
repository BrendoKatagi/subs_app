import 'package:substore_app/features/store/domain/entities/check_in.dart';
import 'package:substore_app/features/store/domain/repositories/check_in_data_repository.dart';

class GetCheckInsUseCase {
  final CheckInDataRepository checkInDataRepository;

  GetCheckInsUseCase({required this.checkInDataRepository});

  Future<List<CheckIn>> call() => checkInDataRepository.getCheckIns();
}
