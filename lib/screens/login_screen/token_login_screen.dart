import 'package:anonaddy/state_management/login_state_manager.dart';
import 'package:anonaddy/utilities/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

final loginStateManagerProvider =
    ChangeNotifierProvider((ref) => LoginStateManager());

class TokenLoginScreen extends ConsumerWidget {
  final _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Size size = MediaQuery.of(context).size;
    final loginManager = watch(loginStateManagerProvider);
    final isLoading = loginManager.isLoading;
    final login = loginManager.login;
    final pasteFromClipboard = loginManager.pasteFromClipboard;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: kBlueNavyColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: size.width * 0.5,
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  height: size.height * 0.6,
                  width: size.width * 0.8,
                  padding: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Welcome!',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Divider(
                            color: Color(0xFFE4E7EB),
                            thickness: 2,
                            indent: size.width * 0.30,
                            endIndent: size.width * 0.30,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Login with Access Token',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      validator: (input) => FormValidator()
                                          .accessTokenValidator(input),
                                      controller: _textEditingController,
                                      onFieldSubmitted: (input) => login(
                                          context,
                                          _textEditingController.text.trim(),
                                          _formKey),
                                      textInputAction: TextInputAction.go,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                        border: OutlineInputBorder(),
                                        hintText: 'Paste here!',
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.paste),
                                    onPressed: () => pasteFromClipboard(
                                      _textEditingController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              GestureDetector(
                                child: Text('How to get Access Token?'),
                                onTap: () {
                                  //todo add how to get Access Token
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.1,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F7FA),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        child: RaisedButton(
                          child: isLoading
                              ? CircularProgressIndicator(
                                  backgroundColor: kBlueNavyColor)
                              : Text(
                                  'Login',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                          onPressed: () => login(
                            context,
                            _textEditingController.text.trim(),
                            _formKey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
