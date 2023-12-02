import 'package:cloud_firestore/cloud_firestore.dart';

class DIYModel {
  String description;
  String id;
  String imagePath;
  List<String> steps;
  String title;

  DIYModel({
    required this.description,
    required this.id,
    required this.imagePath,
    required this.steps,
    required this.title,
  });

  factory DIYModel.fromJson(Map<String, dynamic> json) {
    return DIYModel(
      description: json['description'],
      id: json['id'],
      imagePath: json['imagePath'],
      steps: List<String>.from(json['steps']),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': id,
      'imagePath': imagePath,
      'steps': steps,
      'title': title,
    };
  }

  static DIYModel fromSnapshot(DocumentSnapshot snap) {
    DIYModel diyModel = DIYModel(
      description: snap['description'] ?? "description",
      id: snap['id'],
      imagePath: snap['imagePath'],
      steps: List<String>.from(snap['steps']),
      title: snap['title'],
    );
    return diyModel;
  }
}
