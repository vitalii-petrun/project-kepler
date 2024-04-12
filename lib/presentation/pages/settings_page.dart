import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:locale_emoji_flutter/locale_emoji_flutter.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:project_kepler/presentation/themes/refresh_rate_provider.dart';
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
                  _SettingCard(
                    title: context.l10n.screenRefreshRate,
                    tooltip: context.l10n.refreshRateTooltip,
                    child: const _RefreshRateChooser(),
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

class _RefreshRateChooser extends StatelessWidget {
  const _RefreshRateChooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RefreshRateProvider>(
      builder: (context, provider, child) {
        if (provider.availableModes.isEmpty) {
          return const CircularProgressIndicator();
        }

        // Filter and round the display modes
        List<DropdownMenuItem<DisplayMode>> dropdownItems = provider
            .availableModes
            .where((mode) => mode.refreshRate > 0) // Exclude modes with 0 Hz
            .map((mode) {
          // Round the refresh rate for display
          final roundedRate = mode.refreshRate.round();
          return DropdownMenuItem<DisplayMode>(
            value: mode,
            child: Text("$roundedRate Hz"),
          );
        }).toList();

        return DropdownButtonFormField<DisplayMode>(
          value: provider.selectedMode,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          items: dropdownItems,
          borderRadius: BorderRadius.circular(10.0),
          onChanged: (DisplayMode? newMode) {
            if (newMode != null) {
              provider.setDisplayMode(newMode);
            }
          },
        );
      },
    );
  }
}

class _SettingCard extends StatelessWidget {
  final String title;
  final Widget child;
  final String? tooltip; // Optional tooltip message

  const _SettingCard({
    required this.title,
    required this.child,
    this.tooltip,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: context.theme.textTheme.titleLarge,
                  ),
                  // Conditionally display the info icon if a tooltip is provided
                  if (tooltip != null)
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text(tooltip!),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      tooltip: 'Learn more',
                    ),
                ],
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
