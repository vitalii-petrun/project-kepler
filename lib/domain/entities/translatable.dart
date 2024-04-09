abstract class Translatable {
  // Returns a map of field names and their current values
  Map<String, dynamic> getTranslatableFields();

  // Updates the entity with translated values
  void updateWithTranslatedFields(Map<String, dynamic> translatedFields);

  List<Translatable> getNestedTranslatables() => [];
}
