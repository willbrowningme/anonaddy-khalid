import 'package:anonaddy/models/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app.dart';
import 'models/alias/alias.dart';
import 'models/recipient/recipient.dart';
import 'shared_components/constants/changelog_storage_key.dart';
import 'shared_components/constants/offline_data_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Keeps SplashScreen on until following methods are completed.
  FlutterNativeSplash.removeAfter((BuildContext context) async {
    await _initHive();
  });

  await _handleAppUpdate();

  /// Launches app
  runApp(
    /// Phoenix restarts app upon logout
    Phoenix(
      /// Riverpod base widget to store provider state
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}

/// Initializes [Hive] and its adapters.
Future<void> _initHive() async {
  await Hive.initFlutter();

  /// @HiveType(typeId: 0)
  Hive.registerAdapter(AliasAdapter());

  /// @HiveType(typeId: 1)
  Hive.registerAdapter(RecipientAdapter());

  /// @HiveType(typeId: 2)
  Hive.registerAdapter(ProfileAdapter());
}

/// Does housekeeping after app is updated. Does nothing otherwise.
Future<void> _handleAppUpdate() async {
  const secureStorage = FlutterSecureStorage();

  final oldAppVersion =
      await secureStorage.read(key: ChangelogStorageKey.appVersionKey) ?? '';

  /// Gets current app version number using [PackageInfo]
  final appVersion = await PackageInfo.fromPlatform();
  final currentAppVersion = appVersion.version;

  /// Number NOT matching means app has been updated.
  if (oldAppVersion != currentAppVersion) {
    /// delete changelog value from the storage so that [ChangelogWidget] is displayed
    await secureStorage.delete(key: ChangelogStorageKey.changelogKey);

    /// Saves current AppVersion's number to acknowledge that the user
    /// has opened app with this version before.
    await secureStorage.write(
      key: ChangelogStorageKey.appVersionKey,
      value: currentAppVersion,
    );

    /// Deletes stored offline data after an app has been updated.
    /// This is to prevent bugs that may arise from conflicting stored data scheme.
    await secureStorage.delete(key: OfflineDataKey.aliases);
    await secureStorage.delete(key: OfflineDataKey.account);
    await secureStorage.delete(key: OfflineDataKey.username);
    await secureStorage.delete(key: OfflineDataKey.recipients);
    await secureStorage.delete(key: OfflineDataKey.domainOptions);
    await secureStorage.delete(key: OfflineDataKey.domain);
  }
}
