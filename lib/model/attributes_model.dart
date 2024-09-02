import 'dart:convert';

class PetDetails {
  PetStructure petStructure;

  PetDetails({
    required this.petStructure,
  });

  factory PetDetails.fromRawJson(String str) {
    try {
      return PetDetails.fromJson(json.decode(str));
    } catch (e) {
      return PetDetails(petStructure: PetStructure());
    }
  }

  String toRawJson() => json.encode(toJson());

  factory PetDetails.fromJson(Map<String, dynamic> json) => PetDetails(
    petStructure: PetStructure.fromJson(json["petStructure"]),
  );

  Map<String, dynamic> toJson() => {
    "petStructure": petStructure.toJson(),
  };
}

class PetStructure {
  String id;
  String name;
  List<String> types;
  List<Attribute> attributes;
  bool isDeleted;
  bool isActive;

  PetStructure({
    this.id = '',
    this.name = '',
    this.types = const [],
    this.attributes = const [],
    this.isDeleted = false,
    this.isActive = true,
  });

  factory PetStructure.fromRawJson(String str) {
    try {
      return PetStructure.fromJson(json.decode(str));
    } catch (e) {
      return PetStructure();
    }
  }

  String toRawJson() => json.encode(toJson());

  factory PetStructure.fromJson(Map<String, dynamic> json) => PetStructure(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    types: json["types"]?.map((x) => x.toString()).toList() ?? [],
    attributes: json["attributes"]?.map((x) => Attribute.fromJson(x)).toList() ?? [],
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

class Attribute {
  String name;
  bool required;
  List<String> possibleValues;
  String fieldType;
  String fieldValueType;
  bool deleted;
  String id;

  Attribute({
    this.name = '',
    this.required = false,
    this.possibleValues = const [],
    this.fieldType = '',
    this.fieldValueType = '',
    this.deleted = false,
    this.id = '',
  });

  factory Attribute.fromRawJson(String str) {
    try {
      return Attribute.fromJson(json.decode(str));
    } catch (e) {
      return Attribute();
    }
  }

  String toRawJson() => json.encode(toJson());

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    name: json["name"] ?? '',
    required: json["required"] ?? false,
    possibleValues: json["possibleValues"]?.map((x) => x.toString()).toList() ?? [],
    fieldType: json["fieldType"] ?? '',
    fieldValueType: json["fieldValueType"] ?? '',
    deleted: json["deleted"] ?? false,
    id: json["_id"] ?? '',
  );

  // Converts the Attribute object to a JSON map.
  // 
  // Returns a Map<String, dynamic> containing the attribute's properties.
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