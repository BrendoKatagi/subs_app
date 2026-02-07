import 'package:substore_app/features/store/domain/entities/check_in.dart';

abstract class CheckInDataRepository {
  Future<void> sendCheckInData(String checkInData);

  Future<List<CheckIn>> getCheckIns();
}
