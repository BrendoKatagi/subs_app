import 'package:substore_app/features/store/data/models/check_in_model.dart';
import 'package:substore_app/features/store/domain/entities/check_in.dart';
import 'package:substore_app/features/store/domain/repositories/check_in_data_repository.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';
import 'package:substore_app/shared/client/web_client/web_socket_client.dart';
import 'package:substore_app/shared/models/list_model_helper.dart';

class CheckInDataRepositoryImpl extends CheckInDataRepository {
  final WebClient client;
  final WebSocketClient webSocketClient;

  CheckInDataRepositoryImpl({required this.client, required this.webSocketClient});

  @override
  Future<void> sendCheckInData(String checkInData) async {
    await client.post(
      '/ticket/check-in',
      data: {
        'checkInData': checkInData,
      },
    );
  }

  CheckIn _parseToEntity(dynamic item) => CheckInModel.fromJson(item as Map<String, dynamic>).toEntity();

  @override
  Future<List<CheckIn>> getCheckIns() async {
    final response = await client.get('/ticket/check-in');

    final checkIn = ListModelHelper.getList<CheckIn>(
      response.responseData?.data as List,
      _parseToEntity,
    );

    return checkIn;
  }
}
