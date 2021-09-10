import 'package:anonaddy/screens/home_screen.dart';
import 'package:anonaddy/shared_components/constants/url_strings.dart';
import 'package:anonaddy/shared_components/custom_page_route.dart';
import 'package:anonaddy/utilities/niche_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../global_providers.dart';

class LoginStateManager extends ChangeNotifier {
  LoginStateManager() {
    _isLoading = false;
  }

  late bool _isLoading;

  final _showToast = NicheMethod().showToast;

  bool get isLoading => _isLoading;
  set isLoading(bool toggle) {
    _isLoading = toggle;
    notifyListeners();
  }

  Future<void> login(BuildContext context, String accessToken,
      GlobalKey<FormState> tokenFormKey,
      {String? instanceURL, GlobalKey<FormState>? urlFormKey}) async {
    Future<void> login() async {
      if (tokenFormKey.currentState!.validate()) {
        isLoading = true;
        await context
            .read(accessTokenService)
            .validateAccessToken(accessToken, instanceURL)
            .then((value) async {
          if (value == 200) {
            await context.read(accessTokenService).saveLoginCredentials(
                accessToken, instanceURL ?? kAuthorityURL);
            isLoading = false;
            if (instanceURL != null) Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              CustomPageRoute(HomeScreen()),
            );
          }
        }).catchError((error, stackTrace) {
          isLoading = false;
          _showToast(error.toString());
        });
      }
    }

    if (urlFormKey == null) {
      login();
    } else {
      if (urlFormKey.currentState!.validate()) {
        login();
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    await FlutterSecureStorage()
        .deleteAll()
        .whenComplete(() => Phoenix.rebirth(context));
  }
}
