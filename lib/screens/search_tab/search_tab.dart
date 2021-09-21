import 'package:anonaddy/global_providers.dart';
import 'package:anonaddy/models/alias/alias_model.dart';
import 'package:anonaddy/services/data_storage/search_history_storage.dart';
import 'package:anonaddy/services/search/search_service.dart';
import 'package:anonaddy/shared_components/constants/material_constants.dart';
import 'package:anonaddy/shared_components/constants/ui_strings.dart';
import 'package:anonaddy/shared_components/list_tiles/alias_list_tile.dart';
import 'package:anonaddy/state_management/alias_state/alias_notifier.dart';
import 'package:anonaddy/state_management/alias_state/alias_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchTab extends StatelessWidget {
  void search(BuildContext context) {
    final aliasState = context.read(aliasStateNotifier);
    if (aliasState.status == AliasTabStatus.loaded) {
      final aliasData = aliasState.aliasModel!;
      showSearch(
        context: context,
        delegate: SearchService(aliasData.aliases),
      );
    } else {
      context.read(nicheMethods).showToast(kLoadingText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: InkWell(
            child: IgnorePointer(
              child: TextFormField(
                decoration: kTextFormFieldDecoration.copyWith(
                  hintText: kSearchFieldHint,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            onTap: () => search(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kSearchHistory,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextButton(
                child: Text('Clear'),
                onPressed: () => SearchHistoryStorage.getAliasBoxes().clear(),
              ),
            ],
          ),
        ),
        Divider(height: 0),
        ValueListenableBuilder<Box<Alias>>(
          valueListenable: SearchHistoryStorage.getAliasBoxes().listenable(),
          builder: (context, box, __) {
            final aliases = box.values.toList().cast<Alias>();

            if (aliases.isEmpty)
              return Padding(
                padding: EdgeInsets.all(size.height * 0.01),
                child: Row(children: [Text('Nothing to see here.')]),
              );
            else
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: aliases.length,
                  controller:
                      context.read(fabVisibilityStateProvider).searchController,
                  itemBuilder: (context, index) {
                    return AliasListTile(aliasData: aliases[index]);
                  },
                ),
              );
          },
        ),
      ],
    );
  }
}
