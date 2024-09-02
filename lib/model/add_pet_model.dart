import 'dart:convert';

class Addpet {
  List<Pet> pets;

  Addpet({
    required this.pets,
  });

  factory Addpet.fromRawJson(String str) => Addpet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Addpet.fromJson(Map<String, dynamic> json) => Addpet(
        pets: List<Pet>.from(json["pets"].map((x) => Pet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pets": List<dynamic>.from(pets.map((x) => x.toJson())),
      };
}

class Pet {
  String id;
  String name;

  Pet({
    required this.id,
    required this.name,
  });

  factory Pet.fromRawJson(String str) => Pet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
