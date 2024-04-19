import 'package:flutter/material.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/presentation/widgets/animated_heart_button.dart';

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
                  MyWidget(),
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

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isFavourite = false;

  void onToggleFavourite(Event event) {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedHeartButton<Event>(
        item: Event.empty(),
        isFavourite: isFavourite,
        onToggleFavourite: (event) {
          onToggleFavourite(event);
        },
      ),
    );
  }
}
