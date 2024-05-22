import 'package:project_kepler/domain/entities/translatable.dart';

class Article implements Translatable {
  final int id;
  String title;
  final String url;
  final String? imageUrl;
  final String? newsSite;
  String summary;
  final DateTime? publishedAt;
  final DateTime? updatedAt;
  final bool featured;

  Article({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.updatedAt,
    required this.featured,
  });

  @override
  List<Translatable> getNestedTranslatables() {
    return [];
  }

  @override
  Map<String, dynamic> getTranslatableFields() {
    return {
      'summary': summary,
      'title': title,
    };
  }

  @override
  void updateWithTranslatedFields(Map<String, dynamic> translatedFields) {
    if (translatedFields.containsKey('summary')) {
      summary = translatedFields['summary'];
    }
    if (translatedFields.containsKey('title')) {
      title = translatedFields['title'];
    }
  }
}
