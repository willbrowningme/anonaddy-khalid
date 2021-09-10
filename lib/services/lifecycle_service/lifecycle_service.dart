import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global_providers.dart';

class LifecycleService extends StatefulWidget {
  const LifecycleService({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  _LifecycleServiceState createState() => _LifecycleServiceState();
}

class _LifecycleServiceState extends State<LifecycleService>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    context.read(lifecycleState).setLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
