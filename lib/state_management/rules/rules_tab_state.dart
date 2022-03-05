import 'package:anonaddy/models/rules/rules.dart';

enum RulesTabStatus { loading, loaded, failed }

class RulesTabState {
  const RulesTabState({
    required this.status,
    this.rules,
    this.errorMessage,
  });

  final RulesTabStatus status;
  final List<Rules>? rules;
  final String? errorMessage;

  static RulesTabState initialState() {
    return const RulesTabState(
      status: RulesTabStatus.loading,
      rules: [],
      errorMessage: '',
    );
  }

  RulesTabState copyWith({
    RulesTabStatus? status,
    List<Rules>? rules,
    String? errorMessage,
  }) {
    return RulesTabState(
      status: status ?? this.status,
      rules: rules ?? this.rules,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
