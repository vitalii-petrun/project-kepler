import 'package:flutter/material.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          Consumer<AppThemeProvider>(
            builder: (context, provider, child) {
              return DropdownButton<String>(
                value: provider.currentTheme,
                items: [
                  DropdownMenuItem<String>(
                    value: 'light',
                    child: Text(
                      'Light',
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'dark',
                    child: Text(
                      'Dark',
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'system',
                    child: Text(
                      'System',
                    ),
                  ),
                ],
                onChanged: (String? value) {
                  provider.changeTheme(value ?? 'system');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
