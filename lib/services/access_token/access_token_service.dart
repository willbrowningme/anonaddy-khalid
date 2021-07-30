import 'package:anonaddy/shared_components/constants/url_strings.dart';
import 'package:anonaddy/utilities/api_message_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AccessTokenService {
  final _secureStorage = FlutterSecureStorage();
  static const _accessTokenKey = 'accessToken';
  static const _instanceURLKey = 'instanceURLKey';
  String _accessTokenValue = '';
  String _instanceURL = '';

  Future validateAccessToken(String accessToken, {String? instanceURL}) async {
    try {
      final response = await http.get(
        Uri.https(instanceURL ?? kAuthorityURL,
            '$kUnEncodedBaseURL/$kAccountDetailsURL'),
        headers: {
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest",
          "Accept": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );
      if (response.statusCode == 200) {
        return 200;
      } else {
        throw APIMessageHandler().getStatusCodeMessage(response.statusCode);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveLoginCredentials(
      String accessToken, String instanceURL) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _instanceURLKey, value: instanceURL);
  }

  Future<String> getAccessToken() async {
    if (_accessTokenValue.isEmpty) {
      _accessTokenValue = await _secureStorage.read(key: _accessTokenKey) ?? '';
      return _accessTokenValue;
    } else {
      return _accessTokenValue;
    }
  }

  Future<String> getInstanceURL() async {
    final savedURL = await _secureStorage.read(key: _instanceURLKey);
    if (savedURL == null) _instanceURL = kAuthorityURL;
    if (_instanceURL.isEmpty) {
      _instanceURL = await _secureStorage.read(key: _instanceURLKey) ?? '';
      return _instanceURL;
    } else {
      return _instanceURL;
    }
  }
}
