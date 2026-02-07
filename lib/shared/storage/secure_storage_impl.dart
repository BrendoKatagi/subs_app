import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:substore_app/shared/storage/secure_storage.dart';

class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorageImpl({required this.storage});

  @override
  Future<bool> containsKey({required String key}) =>
      storage.containsKey(key: key);

  @override
  Future<void> delete({required String key}) => storage.delete(key: key);

  @override
  Future<void> deleteAll() => storage.deleteAll();

  @override
  Future<String?> read({required String key}) => storage.read(key: key);

  @override
  Future<void> write({required String key, required String value}) =>
      storage.write(key: key, value: value);
}
