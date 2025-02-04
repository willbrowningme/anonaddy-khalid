import 'package:anonaddy/models/account/account.dart';
import 'package:anonaddy/shared_components/constants/anonaddy_string.dart';

enum AccountStatus { loading, loaded, failed }

class AccountState {
  const AccountState({
    required this.status,
    required this.account,
    required this.errorMessage,
  });

  final AccountStatus status;
  final Account account;
  final String errorMessage;

  static AccountState initialState() {
    return AccountState(
      status: AccountStatus.loading,
      account: Account(),
      errorMessage: '',
    );
  }

  AccountState copyWith({
    AccountStatus? status,
    Account? account,
    String? errorMessage,
  }) {
    return AccountState(
      status: status ?? this.status,
      account: account ?? this.account,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'AccountState{status: $status, account: $account, errorMessage: $errorMessage}';
  }
}

extension AccountStateShortcuts on AccountState {
  bool get isSubscriptionFree =>
      account.subscription == AnonAddyString.subscriptionFree;

  bool get isSelfHosted => account.subscription.isEmpty;

  bool get isFailed => status == AccountStatus.failed;

  bool get hasRecipientsReachedLimit =>
      account.recipientCount == account.recipientLimit;

  bool get hasUsernamesReachedLimit =>
      account.usernameCount == account.usernameLimit;

  bool get hasDomainsReachedLimit =>
      account.recipientCount == account.recipientLimit;
}
