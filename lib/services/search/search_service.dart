import 'package:anonaddy/models/alias/alias_data_model.dart';
import 'package:anonaddy/screens/alias_tab/alias_detailed_screen.dart';
import 'package:anonaddy/services/data_storage/search_history_storage.dart';
import 'package:anonaddy/shared_components/alias_list_tile.dart';
import 'package:anonaddy/shared_components/custom_page_route.dart';
import 'package:anonaddy/state_management/providers/class_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchService extends SearchDelegate {
  SearchService(this.searchAliasList);
  final List<AliasDataModel> searchAliasList;

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
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<AliasDataModel> resultAliasList = [];
    List<AliasDataModel> recentSearchesList = [];

    searchAliasList.forEach((element) {
      if (element.email.toLowerCase().contains(query.toLowerCase()) ||
          element.emailDescription
              .toLowerCase()
              .contains(query.toLowerCase())) {
        resultAliasList.add(element);
      }
    });

    final initialList = query.isEmpty ? recentSearchesList : resultAliasList;

    return ListView.builder(
      itemCount: initialList.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: IgnorePointer(
              child: AliasListTile(aliasData: initialList[index])),
          onTap: () {
            SearchHistoryStorage.getAliasBoxes().add(initialList[index]);
            context.read(aliasStateManagerProvider).aliasDataModel =
                initialList[index];
            Navigator.push(context, CustomPageRoute(AliasDetailScreen()));
          },
        );
      },
    );
  }
}
