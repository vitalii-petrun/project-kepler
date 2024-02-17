import 'dart:convert';

import '../../data/models/type_dto.dart';
import '../entities/type.dart';

class TypeDTOToEntityConverter extends Converter<TypeDTO, TypeEntity> {
  @override
  TypeEntity convert(TypeDTO input) {
    return TypeEntity(
      id: input.id,
      name: input.name,
    );
  }
}

class TypeEntityToDTOConverter extends Converter<TypeEntity, TypeDTO> {
  @override
  TypeDTO convert(TypeEntity input) {
    return TypeDTO(
      id: input.id,
      name: input.name,
    );
  }
}
