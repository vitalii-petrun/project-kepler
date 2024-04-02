import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class ChatFAB extends StatelessWidget {
  final Widget child;

  const ChatFAB({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        context: context,
        builder: (context) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
            constraints: BoxConstraints(
                maxHeight: context.screenHeight - context.screenHeight * 0.20),
            child: child),
      ),
      child: const Icon(Icons.auto_awesome),
    );
  }
}
