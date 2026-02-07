import 'package:get_it/get_it.dart';
import 'package:substore_app/features/store/data/check_in_data_repository_impl.dart';
import 'package:substore_app/features/store/domain/repositories/check_in_data_repository.dart';
import 'package:substore_app/features/store/domain/usecases/get_check_ins_usecase.dart';
import 'package:substore_app/features/store/domain/usecases/send_check_in_data_usecase.dart';

class StoreDI {
  static Future<void> register() async {
    GetIt.I.registerFactory<CheckInDataRepository>(
      () => CheckInDataRepositoryImpl(
        client: GetIt.I.get(),
        webSocketClient: GetIt.I.get(),
      ),
    );

    GetIt.I.registerLazySingleton<SendCheckIndDataUseCase>(
      () => SendCheckIndDataUseCase(
        checkInDataRepository: GetIt.I.get(),
      ),
    );
    GetIt.I.registerFactory<GetCheckInsUseCase>(
      () => GetCheckInsUseCase(
        checkInDataRepository: GetIt.I.get(),
      ),
    );
  }
}
