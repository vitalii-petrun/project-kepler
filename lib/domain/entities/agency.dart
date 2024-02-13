class Agency {
  final int id;
  final String name;
  final String abbrev;
  final String? countryCode;
  final String? type;
  final String? description;
  final String? administrator;
  final String? imageUrl;
  final String? logoUrl;

  Agency(
    this.id,
    this.name,
    this.abbrev,
    this.countryCode,
    this.type,
    this.description,
    this.administrator,
    this.imageUrl,
    this.logoUrl,
  );
  Agency.empty()
      : id = 0,
        name = "",
        abbrev = "",
        countryCode = "",
        type = "",
        description = "",
        administrator = "",
        imageUrl = "",
        logoUrl = "";
}
