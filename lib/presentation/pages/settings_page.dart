import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:project_kepler/presentation/widgets/log_out_button.dart';
import 'package:provider/provider.dart';

import '../../l10n/locale_provider.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _SettingCard(
                title: context.l10n.theme,
                child: const _ThemeDropdown(),
              ),
              const SizedBox(height: 20),
              _SettingCard(
                title: context.l10n.language,
                child: const _LanguageDropdown(),
              ),
              const SizedBox(height: 20),
              _SettingCard(
                  title: context.l10n.logOut,
                  child: const SizedBox(
                    width: double.infinity,
                    child: LogoutButton(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingCard({
    required this.title,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  const _LanguageDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return DropdownButtonFormField<String>(
          value: localeProvider.currentLocale,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
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
          onChanged: (String? value) =>
              localeProvider.changeLocale(value ?? 'en'),
        );
      },
    );
  }
}

class _ThemeDropdown extends StatelessWidget {
  const _ThemeDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppThemeProvider>(context);
    return DropdownButtonFormField<String>(
      value: provider.currentTheme,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      items: const [
        DropdownMenuItem<String>(
          value: 'light',
          child: Text('Light'),
        ),
        DropdownMenuItem<String>(
          value: 'dark',
          child: Text('Dark'),
        ),
        DropdownMenuItem<String>(
          value: 'system',
          child: Text('System'),
        )
      ],
      onChanged: (String? value) => provider.changeTheme(value ?? 'system'),
    );
  }
}
