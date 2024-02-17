import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class FailedBody extends StatelessWidget {
  final String message;

  const FailedBody({Key? key, this.message = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: Center(
                child:
                    Text(message, style: context.theme.textTheme.titleLarge)),
          ),
        );
      },
    );
  }
}
