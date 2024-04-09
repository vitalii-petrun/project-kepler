import 'package:flutter/material.dart';
import 'package:project_kepler/presentation/widgets/shimmer_loading_body.dart';

main() async {
  // String text = "Once upon a time";
  // TranslationService translationService = TranslationService();

  // final translator = GoogleTranslator();

  // final input = "Здравствуйте. Ты в порядке?";

  // translator.translate(input, from: 'ru', to: 'en').then(print);
  // // prints Hello. Are you okay?

  // var translation = await translator.translate("Dart is very cool!", to: 'pl');
  // print(translation);
  // // prints Dart jest bardzo fajny!

  // print(await "example".translate(to: 'pt'));
  runApp(
    MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Column(
                children: [
                  LaunchCardPlaceholder(),
                  SizedBox(height: 16),
                  CompactCardPlaceholder(),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // print(await translationService.translateEntity(text, "en")

  return 0;
}
