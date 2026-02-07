import 'package:get_it/get_it.dart';
import 'package:substore_app/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:substore_app/features/store_report/data/clients/store_report_client.dart';
import 'package:substore_app/features/store_report/data/repository/store_report_repository_impl.dart';
import 'package:substore_app/features/store_report/domain/interfaces/store_report_repository.dart';
import 'package:substore_app/features/store_report/domain/useCases/get_store_report_data_usecase.dart';
import 'package:substore_app/features/store_report/presentation/controllers/store_report_cubit.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';

class StoreReportDI {
  static Future<void> register() async {
    GetIt.I.registerFactory<StoreReportClient>(() => StoreReportClientImpl(client: GetIt.I.get<WebClient>()));
    GetIt.I.registerFactory<StoreReportRepository>(() => StoreReportRepositoryImpl(client: GetIt.I.get<StoreReportClient>()));
    GetIt.I.registerFactory<GetStoreReportDataUsecase>(() => GetStoreReportDataUsecaseImpl(storeReportRepository: GetIt.I.get<StoreReportRepository>()));
    GetIt.I.registerFactory<StoreReportCubit>(() => StoreReportCubit(GetIt.I.get<GetUserLoggedUseCase>(), GetIt.I.get<GetStoreReportDataUsecase>()));
  }
}
