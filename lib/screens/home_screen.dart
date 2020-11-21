import 'package:anonaddy/models/alias_data_model.dart';
import 'package:anonaddy/models/user_model.dart';
import 'package:anonaddy/screens/error_screen.dart';
import 'package:anonaddy/screens/profile_screen.dart';
import 'package:anonaddy/screens/settings_screen.dart';
import 'package:anonaddy/services/api_service.dart';
import 'package:anonaddy/widgets/account_card.dart';
import 'package:anonaddy/widgets/alias_card.dart';
import 'package:anonaddy/widgets/create_new_alias.dart';
import 'package:anonaddy/widgets/fetch_data_indicator.dart';
import 'package:anonaddy/widgets/loading_widget.dart';
import 'package:anonaddy/widgets/pop_scope_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final apiService = watch(apiServiceProvider).getUserDataStream();

    return SafeArea(
      child: WillPopScope(
        onWillPop: () => showDialog(
            context: context, builder: (context) => PopScopeDialog()),
        child: StreamBuilder<UserModel>(
          stream: apiService,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return ErrorScreen(
                    label: 'No Internet Connection.\nMake sure you\'re online.',
                    buttonLabel: 'Reload',
                    buttonOnPress: () {});
                break;
              case ConnectionState.waiting:
                return FetchingDataIndicator();
              default:
                if (snapshot.hasData) {
                  for (var item in snapshot.data.aliasDataList) {
                    UserModel(
                      aliasDataList: [
                        AliasDataModel(
                          aliasID: item.aliasID,
                          email: item.email,
                          emailDescription: item.emailDescription,
                          createdAt: item.createdAt,
                          isAliasActive: item.isAliasActive,
                        ),
                      ],
                    );
                  }
                  return Scaffold(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    appBar: buildAppBar(context),
                    floatingActionButton: buildFloatingActionButton(context),
                    body: SingleChildScrollView(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          AccountCard(userData: snapshot.data),
                          AliasCard(aliasDataList: snapshot.data.aliasDataList),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return ErrorScreen(
                      label: '${snapshot.error}',
                      buttonLabel: 'Sign In',
                      buttonOnPress: () {});
                } else {
                  return LoadingWidget();
                }
            }
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(
        'assets/images/logo.svg',
        height: MediaQuery.of(context).size.height * 0.03,
      ),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.account_circle, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          }),
      actions: [
        IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            }),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return CreateNewAlias();
            });
      },
    );
  }
}
