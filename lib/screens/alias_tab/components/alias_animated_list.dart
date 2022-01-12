import 'package:flutter/material.dart';

class AliasAnimatedList extends StatelessWidget {
  const AliasAnimatedList({
    Key? key,
    required this.listKey,
    required this.itemCount,
    required this.itemBuilder,
  }) : super(key: key);
  final GlobalKey<AnimatedListState> listKey;
  final int itemCount;
  final Widget Function(BuildContext context, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: itemCount,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.7, 0),
            end: Offset(0, 0),
          ).animate(animation),
          child: itemBuilder(context, index),
        );
      },
    );
  }
}
