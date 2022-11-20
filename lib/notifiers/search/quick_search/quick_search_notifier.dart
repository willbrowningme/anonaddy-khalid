import 'package:anonaddy/models/alias/alias.dart';
import 'package:anonaddy/services/search/search_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quickSearchStateNotifier = StateNotifierProvider.autoDispose<
    QuickSearchNotifier, AsyncValue<List<Alias>?>>((ref) {
  final cancelToken = CancelToken();
  final searchService = ref.read(searchServiceProvider);
  return QuickSearchNotifier(
    searchService: searchService,
    cancelToken: cancelToken,
  );
});

class QuickSearchNotifier extends StateNotifier<AsyncValue<List<Alias>?>> {
  QuickSearchNotifier({
    required this.searchService,
    required this.cancelToken,
  }) : super(const AsyncData(null));

  final SearchService searchService;
  final CancelToken cancelToken;

  Future<void> search(String keyword) async {
    if (keyword.length >= 2) {
      if (!mounted) return;
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () => searchService.searchAliases(keyword.trim(), true),
      );
    }
  }

  void cancelSearch() {
    cancelToken.cancel();
  }

  void resetSearch() {
    if (!mounted) return;
    state = const AsyncData(null);
  }
}
