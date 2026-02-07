import 'package:substore_app/features/store_report/domain/entities/store_report.dart';

abstract class StoreReportRepository {
  Future<StoreReport> getStoreReportData({required String storeId});
}
