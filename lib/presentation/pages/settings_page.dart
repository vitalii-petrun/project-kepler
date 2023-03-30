import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:provider/provider.dart';

import '../../l10n/locale_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: Column(
        children: [
          Consumer<AppThemeProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Text(context.l10n.theme),
                  DropdownButton<String>(
                    value: provider.currentTheme,
                    items: [
                      DropdownMenuItem<String>(
                        value: 'light',
                        child: Text(context.l10n.light),
                      ),
                      DropdownMenuItem<String>(
                        value: 'dark',
                        child: Text(context.l10n.dark),
                      ),
                      DropdownMenuItem<String>(
                        value: 'system',
                        child: Text(context.l10n.system),
                      ),
                    ],
                    onChanged: (String? value) {
                      provider.changeTheme(value ?? 'system');
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(context.l10n.language),
                  DropdownButton(
                    value: context.read<LocaleProvider>().currentLocale,
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'en',
                        child: Text('English'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'uk',
                        child: Text('Українська'),
                      )
                    ],
                    onChanged: (String? value) {
                      context
                          .read<LocaleProvider>()
                          .changeLocale(value ?? 'en');
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
