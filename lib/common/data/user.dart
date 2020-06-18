import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final DateTime created;

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        created = (json['created'] as Timestamp).toDate();
}