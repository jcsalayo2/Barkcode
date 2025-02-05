// To parse this JSON data, do
//
//     final navigatorModel = navigatorModelFromJson(jsonString);

import 'dart:convert';

NavigatorModel navigatorModelFromJson(String str) =>
    NavigatorModel.fromJson(json.decode(str));

String navigatorModelToJson(NavigatorModel data) => json.encode(data.toJson());

class NavigatorModel {
  bool? willRefresh;
  String? mode;

  NavigatorModel({
    this.willRefresh,
    this.mode,
  });

  factory NavigatorModel.fromJson(Map<String, dynamic> json) => NavigatorModel(
        willRefresh: json["willRefresh"],
        mode: json["mode"],
      );

  Map<String, dynamic> toJson() => {
        "willRefresh": willRefresh,
        "mode": mode,
      };
}
