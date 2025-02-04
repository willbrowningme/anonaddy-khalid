import 'package:anonaddy/notifiers/account/account_state.dart';
import 'package:anonaddy/services/access_token/access_token_service.dart';
import 'package:anonaddy/shared_components/constants/app_strings.dart';
import 'package:anonaddy/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountPopupInfo extends ConsumerWidget {
  const AccountPopupInfo({
    Key? key,
    required this.accountState,
  }) : super(key: key);
  final AccountState accountState;

  String getSubscriptionExpirationDate(BuildContext context) {
    /// Self hosted instances do NOT have a subscription and do not expire.
    if (accountState.isSelfHosted) {
      return AppStrings.subscriptionEndDateDoesNotExpire;
    }

    /// addy.io free subscriptions do NOT expire.
    if (accountState.isSubscriptionFree) {
      return AppStrings.subscriptionEndDateDoesNotExpire;
    }

    /// addy.io Lite and Pro subscriptions do expire.
    return accountState.account.subscriptionEndAt.isEmpty
        ? AppStrings.subscriptionEndDateNotAvailable
        : Utilities.formatDateTime(context, accountState.account.createdAt);
  }

  Future<void> updateDefaultAliasFormatDomain(WidgetRef ref) async {
    final instanceURL =
        await ref.read(accessTokenServiceProvider).getInstanceURL();
    await Utilities.launchURL('https://$instanceURL/settings');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = accountState.account;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          tileColor: Colors.transparent,
          title: Text(
            account.defaultAliasFormat.isEmpty
                ? AppStrings.noDefaultSelected
                : Utilities.correctAliasString(account.defaultAliasFormat),
          ),
          subtitle: const Text(AppStrings.defaultAliasFormat),
          trailing: const Icon(Icons.open_in_new_outlined),
          onTap: () => updateDefaultAliasFormatDomain(ref),
        ),
        ListTile(
          dense: true,
          title: Text(
            account.defaultAliasDomain.isEmpty
                ? AppStrings.noDefaultSelected
                : account.defaultAliasDomain,
          ),
          subtitle: const Text(AppStrings.defaultAliasDomain),
          trailing: const Icon(Icons.open_in_new_outlined),
          onTap: () => updateDefaultAliasFormatDomain(ref),
        ),
        ListTile(
          dense: true,
          title: Text(getSubscriptionExpirationDate(context)),
          subtitle: const Text(AppStrings.subscriptionEndDate),
        ),
      ],
    );
  }
}
