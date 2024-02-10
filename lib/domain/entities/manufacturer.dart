class Manufacturer {
  final int id;
  final String url;
  final String name;
  final String type;

  final String countryCode;
  final String abbrev;
  final String? description;
  final String? administrator;

  final String? foundingYear;
  final String spacecraft;

  final String? imageUrl;

  final String? logoUrl;

  Manufacturer(
    this.id,
    this.url,
    this.name,
    this.type,
    this.countryCode,
    this.abbrev,
    this.description,
    this.administrator,
    this.foundingYear,
    this.spacecraft,
    this.imageUrl,
    this.logoUrl,
  );
}
