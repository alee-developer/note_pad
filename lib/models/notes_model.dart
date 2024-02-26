// To parse this JSON data, do
//
//     final notesModel = notesModelFromJson(jsonString);

import 'dart:convert';

NotesModel notesModelFromJson(String str) => NotesModel.fromJson(json.decode(str));

String notesModelToJson(NotesModel data) => json.encode(data.toJson());

class NotesModel {
  int? id;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;

  NotesModel({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
