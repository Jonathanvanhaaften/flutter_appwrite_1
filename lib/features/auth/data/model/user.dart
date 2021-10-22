// class UserFields {
//   static const String id = "\$id";
//   static const String name = "name";
//   static const String email = "email";
//   static const String registrationDate = "registration";
//   static const String roles = "roles";
// }

// class User {
//   String? id;
//   String? email;
//   int? registration;
//   String? name;
//   List<String>? roles;

//   User({this.id, this.email, this.registration, this.name, this.roles});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json[UserFields.id];
//     email = json[UserFields.email];
//     registration = json[UserFields.registrationDate];
//     name = json[UserFields.name];
//     roles = json[UserFields.roles].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data[UserFields.id] = id;
//     data[UserFields.email] = email;
//     data[UserFields.registrationDate] = registration;
//     data[UserFields.name] = name;
//     data[UserFields.roles] = roles;
//     return data;
//   }
// }

import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final DateTime registration;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.registration,
    required this.email,
  });

  User copyWith({
    String? id,
    String? name,
    DateTime? registration,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      registration: registration ?? this.registration,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '\$id': id,
      'name': name,
      'registration': registration.millisecondsSinceEpoch,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['\$id'],
      name: map['name'],
      registration: DateTime.fromMillisecondsSinceEpoch(map['registration']),
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, registration: $registration,  email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.registration == registration &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ registration.hashCode ^ email.hashCode;
  }
}
