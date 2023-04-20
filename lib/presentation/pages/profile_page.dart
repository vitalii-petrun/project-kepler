import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 80,
              /*   backgroundImage: AssetImage('assets/profile_picture.png'), */
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.name,
              style: context.theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.email,
              style: context.theme.textTheme.titleLarge,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.theme.colorScheme.error,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(context.l10n.logout),
            ),
          ],
        ),
      ),
    );
  }
}
