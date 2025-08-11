
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ApiKeyRepository {
  static const String _apiKeyKey = 'api_key';

  Future<String> getApiKey() async {
    try {
      final apiKey = await _secureStorage.read(key: _apiKeyKey);
      return apiKey ?? '';
    } catch (e) {
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
      throw ApiKeyException('Failed to save API key: $e');
    }
  }

  Future<void> deleteApiKey() async {
    try {
      await _secureStorage.delete(key: _apiKeyKey);
    } catch (e) {
      throw ApiKeyException('Failed to delete API key: $e');
    }
  }

  Future<bool> hasApiKey() async {
    try {
      final apiKey = await getApiKey();
      return apiKey.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isValidApiKey(String apiKey) async {
    // Add your API key validation logic here
    return apiKey.trim().isNotEmpty && apiKey.trim().length >= 10;
  }
}

// Private secure storage instance
const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);

// Custom exception for API key operations
class ApiKeyException implements Exception {
  final String message;
  const ApiKeyException(this.message);
  
  @override
  String toString() => 'ApiKeyException: $message';
}