// To parse this JSON data, do
//
//     final pet = petFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Pet petFromJson(String str) => Pet.fromJson(json.decode(str));

String petToJson(Pet data) => json.encode(data.toJson());

class Pet {
  String name;
  String id;
  DateTime birthday;
  String contact;
  String gender;
  int petCount;
  String userId;
  Images images;
  String breed;

  Pet({
    required this.name,
    required this.id,
    required this.birthday,
    required this.contact,
    required this.gender,
    required this.petCount,
    required this.userId,
    required this.images,
    required this.breed,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        name: json["name"],
        id: json["id"],
        birthday: json["birthday"].toDate(),
        contact: json["contact"],
        gender: json["gender"],
        petCount: json["petCount"],
        userId: json["userId"],
        images: Images.fromJson(json["images"]),
        breed: json["breed"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "birthday": birthday,
        "contact": contact,
        "gender": gender,
        "petCount": petCount,
        "userId": userId,
        "images": images.toJson(),
        "breed": breed,
      };
}

class Images {
  String coverPicture;
  String profilePicture;
  List<String> album;

  Images({
    required this.coverPicture,
    required this.profilePicture,
    required this.album,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        coverPicture: json["coverPicture"],
        profilePicture: json["profilePicture"],
        album: List<String>.from(json["album"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "coverPicture": coverPicture,
        "profilePicture": profilePicture,
        "album": List<dynamic>.from(album.map((x) => x)),
      };
}
