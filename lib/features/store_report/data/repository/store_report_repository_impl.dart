import 'package:substore_app/features/store_report/data/clients/store_report_client.dart';
import 'package:substore_app/features/store_report/domain/entities/store_report.dart';
import 'package:substore_app/features/store_report/domain/interfaces/store_report_repository.dart';

class StoreReportRepositoryImpl implements StoreReportRepository {
  final StoreReportClient _client;

  StoreReportRepositoryImpl({required StoreReportClient client}) : _client = client;

  @override
  Future<StoreReport> getStoreReportData({required String storeId}) async {
    try {
      final result = await _client.getStoreReportData(storeId: storeId);
      return StoreReport.fromJson(result);
    } catch (error) {
      throw Exception('StoreReportRepository - getStoreReportData: $error');
    }
  }
}
