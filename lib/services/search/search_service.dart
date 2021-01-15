import 'package:anonaddy/models/alias/alias_data_model.dart';
import 'package:anonaddy/screens/alias_tab/alias_detailed_screen.dart';
import 'package:anonaddy/screens/alias_tab/alias_list_tile.dart';
import 'package:anonaddy/state_management/alias_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchService extends SearchDelegate {
  SearchService(this._aliasDataList);
  final List<AliasDataModel> _aliasDataList;

  final List<AliasDataModel> _recentSearches = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? Container()
          : IconButton(icon: Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final aliasDataProvider = context.read(aliasStateManagerProvider);

    List<AliasDataModel> _resultList = [];

    _aliasDataList.forEach((element) {
      if (element.email.toLowerCase().contains(query.toLowerCase()) ||
          element.emailDescription
              .toLowerCase()
              .contains(query.toLowerCase())) {
        _resultList.add(element);
      }
    });

    final initialList = query.isEmpty ? _recentSearches : _resultList;

    return ListView.builder(
      itemCount: initialList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            aliasDataProvider.aliasDataModel = initialList[index];
            aliasDataProvider.setSwitchValue(initialList[index].isAliasActive);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AliasDetailScreen();
                },
              ),
            );
            _recentSearches.add(initialList[index]);
          },
          child: AliasListTile(
            aliasData: initialList[index],
          ),
        );
      },
    );
  }
}
