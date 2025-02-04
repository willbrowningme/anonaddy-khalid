import 'package:anonaddy/models/alias/alias.dart';
import 'package:anonaddy/notifiers/alias_state/alias_tab_notifier.dart';
import 'package:anonaddy/notifiers/alias_state/alias_tab_state.dart';
import 'package:anonaddy/services/alias/alias_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAliasService extends Mock implements AliasService {}

void main() {
  late MockAliasService aliasService;
  late AliasTabNotifier aliasTabNotifier;

  setUp(() {
    aliasService = MockAliasService();
    aliasTabNotifier = AliasTabNotifier(
      aliasService: aliasService,
    );
  });

  test('test initialState() method', () async {
    expect(
      aliasTabNotifier.debugState,
      AliasTabState.initialState(),
    );
  });

  test('test getAliases() method', () {
    final aliases = aliasTabNotifier.getAliases();
    expect(aliases, []);
  });

  test('test addAlias(alias) method', () {
    expect(aliasTabNotifier.debugState.availableAliasList.length, 0);
    expect(aliasTabNotifier.debugState.deletedAliasList.length, 0);

    final alias = Alias();
    aliasTabNotifier.addAlias(alias);
    expect(aliasTabNotifier.debugState.availableAliasList.length, 1);
    expect(aliasTabNotifier.debugState.deletedAliasList.length, 0);

    final newAlias = Alias(id: 'new');
    aliasTabNotifier.addAlias(newAlias);
    expect(aliasTabNotifier.debugState.availableAliasList.length, 2);
    expect(aliasTabNotifier.debugState.availableAliasList[0], newAlias);
    expect(aliasTabNotifier.debugState.availableAliasList[1], alias);
    expect(aliasTabNotifier.debugState.deletedAliasList.length, 0);
  });

  test('test deleteAlias(alias) method', () {
    final initialState = AliasTabState.initialState();
    final alias = Alias();
    final updatedState = initialState.copyWith(availableAliasList: [alias]);

    final aliasTabNotifier = AliasTabNotifier(
      aliasService: aliasService,
      initialState: updatedState,
    );

    expect(aliasTabNotifier.debugState.availableAliasList.length, 1);
    expect(aliasTabNotifier.debugState.deletedAliasList.length, 0);

    aliasTabNotifier.removeDeletedAlias(alias);
    expect(aliasTabNotifier.debugState.availableAliasList.length, 0);
    expect(aliasTabNotifier.debugState.deletedAliasList.length, 0);
  });

  test('test removeRestoredAlias(alias) method', () {
    final initialState = AliasTabState.initialState();
    final alias = Alias();
    final updatedState = initialState.copyWith(deletedAliasList: [alias]);

    final aliasTabNotifier = AliasTabNotifier(
      aliasService: aliasService,
      initialState: updatedState,
    );

    expect(aliasTabNotifier.debugState.availableAliasList.length, 0);
    expect(aliasTabNotifier.debugState.deletedAliasList.length, 1);

    aliasTabNotifier.removeRestoredAlias(alias);
    expect(aliasTabNotifier.debugState.availableAliasList.length, 0);
    expect(aliasTabNotifier.debugState.deletedAliasList.length, 0);
  });
}
