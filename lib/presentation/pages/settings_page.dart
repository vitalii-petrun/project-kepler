import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locale_emoji_flutter/locale_emoji_flutter.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:project_kepler/presentation/widgets/log_out_button.dart';
import 'package:project_kepler/presentation/widgets/space_drawer.dart';
import 'package:provider/provider.dart';

import '../../l10n/locale_provider.dart';
import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/authentication/authentication_state.dart';
import '../widgets/rounded_app_bar.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const SpaceDrawer(),
      appBar: RoundedAppBar(title: Text(context.l10n.settings)),
      body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return SafeArea(
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
                  if (state is Authenticated)
                    _SettingCard(
                        title: context.l10n.logOut,
                        child: const SizedBox(
                          width: double.infinity,
                          child: LogoutButton(),
                        )),
                  if (state is! Authenticated)
                    _SettingCard(
                      title: context.l10n.logIn,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            context.router.pushNamed('/login');
                          },
                          child: Text(context.l10n.logIn,
                              style: context.theme.textTheme.labelLarge
                                  ?.copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
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
          borderRadius: BorderRadius.circular(10.0),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          items: [
            DropdownMenuItem<String>(
                value: 'en',
                child: Text('${const Locale('en').flagEmoji}  English')),
            DropdownMenuItem<String>(
              value: 'uk',
              child: Text(' ${const Locale('uk').flagEmoji}  Українська'),
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
      borderRadius: BorderRadius.circular(10.0),
      value: provider.currentTheme,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      items: [
        DropdownMenuItem<String>(
          value: 'light',
          child: Text('☀️  ${context.l10n.light}'),
        ),
        DropdownMenuItem<String>(
          value: 'dark',
          child: Text('🌙  ${context.l10n.dark}'),
        ),
        DropdownMenuItem<String>(
          value: 'system',
          child: Text('🌐  ${context.l10n.system}'),
        )
      ],
      onChanged: (String? value) => provider.changeTheme(value ?? 'system'),
    );
  }
}
