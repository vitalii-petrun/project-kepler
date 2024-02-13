import 'dart:convert';

import '../../data/models/agency_dto.dart';
import '../entities/agency.dart';

class AgencyDtoToEntityConverter extends Converter<AgencyDTO, Agency> {
  @override
  Agency convert(AgencyDTO input) {
    return Agency(
      input.id,
      input.name,
      input.abbrev,
      input.countryCode,
      input.type,
      input.description,
      input.administrator,
      input.imageUrl,
      input.logoUrl,
    );
  }
}

class AgencyEntityToDtoConverter extends Converter<Agency, AgencyDTO> {
  @override
  AgencyDTO convert(Agency input) {
    return AgencyDTO(
      input.id,
      input.name,
      input.abbrev,
      input.countryCode,
      input.type,
      input.description,
      input.administrator,
      input.imageUrl,
      input.logoUrl,
    );
  }
}
