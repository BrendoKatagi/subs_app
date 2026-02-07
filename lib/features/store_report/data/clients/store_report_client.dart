import 'package:substore_app/shared/client/web_client/web_client.dart';
import 'package:substore_app/typedefs.dart';

abstract class StoreReportClient {
  Future<JsonObject> getStoreReportData({required String storeId});
}

class StoreReportClientImpl implements StoreReportClient {
  final WebClient client;

  StoreReportClientImpl({required this.client});
  @override
  Future<JsonObject> getStoreReportData({required String storeId}) async {
    try {
      final String path = '/ticket/store/$storeId';
      final ClientResponse response = await client.get(path);

      return response.responseData?.data as JsonObject;
    } catch (error) {
      throw Exception('StoreReportClient - getStoreReportData: $error');
    }
  }
}
