import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:provider/provider.dart';

import '../../l10n/locale_provider.dart';

@RoutePage()
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
                  const SizedBox(height: 20),
                  _SettingPanel(
                    title: context.l10n.theme,
                    child: _ThemeModeToggles(provider: provider),
                  ),
                  const SizedBox(height: 10),
                  _SettingPanel(
                    title: context.l10n.language,
                    child: const _LanguageDropdownButton(),
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

class _SettingPanel extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingPanel({
    required this.title,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: context.screenWidth / 10, top: 10, bottom: 10),
      color: context.theme.colorScheme.secondary.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [SizedBox(width: 100, child: Text(title)), child],
      ),
    );
  }
}

class _LanguageDropdownButton extends StatelessWidget {
  const _LanguageDropdownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(builder: (context, localeProvider, child) {
      return DropdownButton(
        value: localeProvider.currentLocale,
        borderRadius: BorderRadius.circular(10),
        elevation: 0,
        underline: const SizedBox(),
        alignment: Alignment.center,
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
    });
  }
}

class _ThemeModeToggles extends StatelessWidget {
  final AppThemeProvider provider;
  const _ThemeModeToggles({required this.provider, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        tapTargetSize: MaterialTapTargetSize.padded,
        isSelected: [
          provider.currentTheme == 'light',
          provider.currentTheme == 'dark',
          provider.currentTheme == 'system',
        ],
        onPressed: (int index) {
          if (index == 0) {
            provider.changeTheme('light');
          } else if (index == 1) {
            provider.changeTheme('dark');
          } else {
            provider.changeTheme('system');
          }
        },
        children: [
          Text(context.l10n.light),
          Text(context.l10n.dark),
          Text(context.l10n.system),
        ]);
  }
}
