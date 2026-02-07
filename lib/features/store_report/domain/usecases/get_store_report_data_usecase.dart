import 'package:substore_app/features/store_report/domain/entities/store_report.dart';
import 'package:substore_app/features/store_report/domain/interfaces/store_report_repository.dart';

abstract class GetStoreReportDataUsecase {
  Future<StoreReport> call({required String storeId});
}

class GetStoreReportDataUsecaseImpl implements GetStoreReportDataUsecase {
  final StoreReportRepository _storeReportRepository;

  GetStoreReportDataUsecaseImpl({required StoreReportRepository storeReportRepository}) : _storeReportRepository = storeReportRepository;
  @override
  Future<StoreReport> call({required String storeId}) async {
    return _storeReportRepository.getStoreReportData(storeId: storeId);
  }
}
