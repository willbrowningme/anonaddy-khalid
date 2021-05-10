import 'package:anonaddy/models/alias/alias_data_model.dart';
import 'package:anonaddy/services/data_storage/search_history_storage.dart';
import 'package:anonaddy/services/search/search_service.dart';
import 'package:anonaddy/shared_components/alias_list_tile.dart';
import 'package:anonaddy/shared_components/constants/material_constants.dart';
import 'package:anonaddy/shared_components/constants/ui_strings.dart';
import 'package:anonaddy/state_management/providers/class_providers.dart';
import 'package:anonaddy/state_management/providers/global_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.01),
            child: InkWell(
              child: IgnorePointer(
                child: TextFormField(
                  decoration: kTextFormFieldDecoration.copyWith(
                    hintText: kSearchHintText,
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              onTap: () {
                final aliasProvider = context.read(aliasDataStream).data;
                if (aliasProvider == null) {
                  context
                      .read(aliasStateManagerProvider)
                      .showToast('Loading...');
                } else {
                  showSearch(
                    context: context,
                    delegate: SearchService(aliasProvider.value.aliasDataList),
                  );
                }
              },
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.082,
          left: 0,
          right: 0,
          bottom: 0,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(size.height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Search History',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextButton(
                      child: Text('Clear'),
                      onPressed: () =>
                          SearchHistoryStorage.getAliasBoxes().clear(),
                    ),
                  ],
                ),
                Divider(),
                ValueListenableBuilder<Box<AliasDataModel>>(
                  valueListenable:
                      SearchHistoryStorage.getAliasBoxes().listenable(),
                  builder: (context, box, __) {
                    final aliases = box.values.toList().cast<AliasDataModel>();

                    if (aliases.isEmpty)
                      return buildEmptyListWidget();
                    else
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: aliases.length,
                        itemBuilder: (context, index) {
                          return AliasListTile(aliasData: aliases[index]);
                        },
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmptyListWidget() {
    return Text('Nothing to see here.');
  }
}
