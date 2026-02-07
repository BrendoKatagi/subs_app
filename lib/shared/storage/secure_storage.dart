abstract class SecureStorage {
  Future<String?> read({required String key});

  Future<bool> containsKey({required String key});

  Future<void> delete({required String key});

  Future<void> deleteAll();

  Future<void> write({required String key, required String value});
}
