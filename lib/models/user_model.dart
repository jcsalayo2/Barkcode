// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserFirebase userFromJson(String str) => UserFirebase.fromJson(json.decode(str));

String userToJson(UserFirebase data) => json.encode(data.toJson());

class UserFirebase {
  String name;

  UserFirebase({
    required this.name,
  });

  factory UserFirebase.fromJson(Map<String, dynamic> json) => UserFirebase(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
