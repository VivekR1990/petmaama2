import 'dart:convert';

class SubmitPet {
  SubmitPetStructure petStructure;

  SubmitPet({
    required this.petStructure,
  });

  factory SubmitPet.fromRawJson(String str) {
    try {
      return SubmitPet.fromJson(json.decode(str));
    } catch (e) {
      return SubmitPet(petStructure: SubmitPetStructure());
    }
  }

  String toRawJson() => json.encode(toJson());

  factory SubmitPet.fromJson(Map<String, dynamic> json) => SubmitPet(
    petStructure: SubmitPetStructure.fromJson(json["petStructure"]),
  );

  Map<String, dynamic> toJson() => {
    "petStructure": petStructure.toJson(),
  };
}

class SubmitPetStructure {
  String id;
  String name;
  List<String> types;
  List<PetAttribute> attributes;
  bool isDeleted;
  bool isActive;

  SubmitPetStructure({
    this.id = '',
    this.name = '',
    this.types = const [],
    this.attributes = const [],
    this.isDeleted = false,
    this.isActive = true,
  });

  factory SubmitPetStructure.fromRawJson(String str) {
    try {
      return SubmitPetStructure.fromJson(json.decode(str));
    } catch (e) {
      return SubmitPetStructure();
    }
  }

  String toRawJson() => json.encode(toJson());

  factory SubmitPetStructure.fromJson(Map<String, dynamic> json) => SubmitPetStructure(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    types: json["types"]?.map((x) => x.toString()).toList() ?? [],
    attributes: json["attributes"]?.map((x) => PetAttribute.fromJson(x)).toList() ?? [],
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? true,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "types": types,
    "attributes": attributes.map((x) => x.toJson()).toList(),
    "isDeleted": isDeleted,
    "isActive": isActive,
  };
}

class PetAttribute {
  String name;
  bool required;
  List<String> possibleValues;
  String fieldType;
  String fieldValueType;
  bool deleted;
  String id;

  PetAttribute({
    this.name = '',
    this.required = false,
    this.possibleValues = const [],
    this.fieldType = '',
    this.fieldValueType = '',
    this.deleted = false,
    this.id = '',
  });

  factory PetAttribute.fromRawJson(String str) {
    try {
      return PetAttribute.fromJson(json.decode(str));
    } catch (e) {
      return PetAttribute();
    }
  }

  String toRawJson() => json.encode(toJson());

  factory PetAttribute.fromJson(Map<String, dynamic> json) => PetAttribute(
    name: json["name"] ?? '',
    required: json["required"] ?? false,
    possibleValues: json["possibleValues"]?.map((x) => x.toString()).toList() ?? [],
    fieldType: json["fieldType"] ?? '',
    fieldValueType: json["fieldValueType"] ?? '',
    deleted: json["deleted"] ?? false,
    id: json["_id"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "required": required,
    "possibleValues": possibleValues,
    "fieldType": fieldType,
    "fieldValueType": fieldValueType,
    "deleted": deleted,
    "_id": id,
  };
}