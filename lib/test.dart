import 'package:project_kepler/core/utils/translation_service.dart';

main() async {
  String text = "Once upon a time";
  TranslationService translationService = TranslationService();
  var res = await translationService.translateModel(text, 'uk');

  print(res);

  // final translator = GoogleTranslator();

  // final input = "Здравствуйте. Ты в порядке?";

  // translator.translate(input, from: 'ru', to: 'en').then(print);
  // // prints Hello. Are you okay?

  // var translation = await translator.translate("Dart is very cool!", to: 'pl');
  // print(translation);
  // // prints Dart jest bardzo fajny!

  // print(await "example".translate(to: 'pt'));

  return 0;
}
