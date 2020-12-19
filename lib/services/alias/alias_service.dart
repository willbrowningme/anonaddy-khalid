import 'dart:convert';

import 'package:anonaddy/models/alias/alias_data_model.dart';
import 'package:anonaddy/models/alias/alias_model.dart';
import 'package:anonaddy/utilities/api_message_handler.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../access_token/access_token_service.dart';

class AliasService {
  final _headers = <String, String>{
    "Content-Type": "application/json",
    "X-Requested-With": "XMLHttpRequest",
    "Accept": "application/json",
  };

  Future<AliasModel> getAllAliasesData() async {
    final accessToken = await AccessTokenService().getAccessToken();
    _headers["Authorization"] = "Bearer $accessToken";

    final response = await http.get(
        Uri.encodeFull('$kBaseURL/$kAliasesURL?deleted=with'),
        headers: _headers);

    if (response.statusCode == 200) {
      print('getAllAliasesData ${response.statusCode}');
      return AliasModel.fromJson(jsonDecode(response.body));
    } else {
      print('getAllAliasesData ${response.statusCode}');
      throw APIMessageHandler().getStatusCodeMessage(response.statusCode);
    }
  }

  Future<int> createNewAlias(
      {String desc, String format, String domain}) async {
    final accessToken = await AccessTokenService().getAccessToken();
    _headers["Authorization"] = "Bearer $accessToken";

    final response = await http.post(Uri.encodeFull('$kBaseURL/$kAliasesURL'),
        headers: _headers,
        body: json.encode({
          "domain": "$domain",
          "format": "$format",
          "description": "$desc",
        }));

    if (response.statusCode == 201) {
      print("createNewAlias ${response.statusCode}");
      // return AliasDataModel.fromJsonData(jsonDecode(response.body));
      return response.statusCode;
    } else {
      print("createNewAlias ${response.statusCode}");
      throw APIMessageHandler().getStatusCodeMessage(response.statusCode);
    }
  }

  Future activateAlias(String aliasID) async {
    try {
      final accessToken = await AccessTokenService().getAccessToken();
      _headers["Authorization"] = "Bearer $accessToken";

      final response = await http.post(
        Uri.encodeFull('$kBaseURL/$kActiveAliasURL'),
        headers: _headers,
        body: json.encode({"id": "$aliasID"}),
      );

      if (response.statusCode == 200) {
        print('Network activateAlias ${response.statusCode}');
        return jsonDecode(response.body);
      } else {
        print('Network activateAlias ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future deactivateAlias(String aliasID) async {
    try {
      final accessToken = await AccessTokenService().getAccessToken();
      _headers["Authorization"] = "Bearer $accessToken";

      final response = await http.delete(
          Uri.encodeFull('$kBaseURL/$kActiveAliasURL/$aliasID'),
          headers: _headers);

      if (response.statusCode == 204) {
        print('Network deactivateAlias ${response.statusCode}');
        return response.body;
      } else {
        print('Network deactivateAlias ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> editAliasDescription({String newDescription}) async {
    try {
      final accessToken = await AccessTokenService().getAccessToken();
      _headers["Authorization"] = "Bearer $accessToken";

      final response = await http.patch(
          Uri.encodeFull('$kBaseURL/$kAliasesURL/$newDescription'),
          headers: _headers,
          body: jsonEncode({"description": "$newDescription"}));

      if (response.statusCode == 200) {
        print('Network editDescription ${response.statusCode}');
        return response.body;
      } else {
        print('Network editDescription ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> deleteAlias(String aliasID) async {
    try {
      final accessToken = await AccessTokenService().getAccessToken();
      _headers["Authorization"] = "Bearer $accessToken";

      final response = await http.delete(
          Uri.encodeFull('$kBaseURL/$kAliasesURL/$aliasID'),
          headers: _headers);

      if (response.statusCode == 204) {
        print('Network deleteAlias ${response.statusCode}');
        return response.body;
      } else {
        print('Network deleteAlias ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> restoreAlias(String aliasID) async {
    try {
      final accessToken = await AccessTokenService().getAccessToken();
      _headers["Authorization"] = "Bearer $accessToken";

      final response = await http.patch(
          Uri.encodeFull('$kBaseURL/$kAliasesURL/$aliasID/restore'),
          headers: _headers);

      if (response.statusCode == 200) {
        print('Network restoreAlias ${response.statusCode}');
        return response.body;
      } else {
        print('Network restoreAlias ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<AliasDataModel> getSpecificAliasData(String aliasID) async {
    final accessToken = await AccessTokenService().getAccessToken();
    _headers["Authorization"] = "Bearer $accessToken";

    final response = await http.get(
        Uri.encodeFull('$kBaseURL/$kAliasesURL/$aliasID'),
        headers: _headers);

    if (response.statusCode == 200) {
      final data = AliasDataModel.fromJsonData(jsonDecode(response.body));
      return data;
    } else {
      return null;
    }
  }
}
