import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Repository for handling the openai api key.
/// Api key is stored in secure storage.
class ApiKeyRepository {
  static const String _apiKeyKey = 'api_key';

  Future<String> getApiKey() async {
    try {
      final apiKey = await _secureStorage.read(key: _apiKeyKey);
      return apiKey ?? '';
    } catch (e) {
      debugPrint(e.toString());
      throw ApiKeyException('Failed to retrieve API key: $e');
    }
  }

  Future<void> saveApiKey(String apiKey) async {
    try {
      final trimmedApiKey = apiKey.trim();
      if (trimmedApiKey.isEmpty) {
        await _secureStorage.delete(key: _apiKeyKey);
      } else {
        await _secureStorage.write(key: _apiKeyKey, value: trimmedApiKey);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw ApiKeyException('Failed to save API key: $e');
    }
  }

  Future<void> deleteApiKey() async {
    try {
      await _secureStorage.delete(key: _apiKeyKey);
    } catch (e) {
      debugPrint(e.toString());
      throw ApiKeyException('Failed to delete API key: $e');
    }
  }
}

const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);

class ApiKeyException implements Exception {
  final String message;
  const ApiKeyException(this.message);

  @override
  String toString() => 'ApiKeyException: $message';
}
