import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_management/lifecycle_state_manager.dart';

class LifecycleService extends StatefulWidget {
  const LifecycleService({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  _LifecycleServiceState createState() => _LifecycleServiceState();
}

class _LifecycleServiceState extends State<LifecycleService>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    context
        .read(lifecycleStateManagerProvider)
        .setForegroundState(_getLifecycleState(state));
  }

  bool _getLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        return false;
      case AppLifecycleState.detached:
        return false;
      case AppLifecycleState.paused:
        return false;
      case AppLifecycleState.resumed:
        return true;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
