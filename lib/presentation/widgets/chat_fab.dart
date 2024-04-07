import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:sheet/sheet.dart';
import 'package:sheet/route.dart';

class ChatFAB extends StatelessWidget {
  final Widget child;

  const ChatFAB({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          FloatingSheetRoute(
            builder: (context) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                constraints: BoxConstraints(
                    maxHeight:
                        context.screenHeight - context.screenHeight * 0.10),
                child: child,
              );
            },
          ),
        );
      },
      child: const Icon(Icons.auto_awesome),
    );
  }
}

class FloatingModal extends StatelessWidget {
  const FloatingModal({super.key, required this.child, this.backgroundColor});
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(
        color: backgroundColor,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    );
  }
}

class FloatingSheetRoute<T> extends SheetRoute<T> {
  FloatingSheetRoute({
    required WidgetBuilder builder,
  }) : super(
          builder: (BuildContext context) {
            return FloatingModal(
              child: Builder(builder: builder),
            );
          },
          fit: SheetFit.loose,
        );
}
