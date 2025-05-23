import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String gameName;
  final String whatsapp;
  final String role;
  final String joinDate;
  String? photoUrl;
  
  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.gameName,
    required this.whatsapp,
    required this.role,
    required this.joinDate,
    this.photoUrl,
  });
  
  // Construtor de cópia com possibilidade de alterar campos
  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? gameName,
    String? whatsapp,
    String? role,
    String? joinDate,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      gameName: gameName ?? this.gameName,
      whatsapp: whatsapp ?? this.whatsapp,
      role: role ?? this.role,
      joinDate: joinDate ?? this.joinDate,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
  
  // Converter de Map para UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      gameName: map['gameName'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      role: map['role'] ?? 'member',
      joinDate: map['joinDate'] ?? DateTime.now().toIso8601String(),
      photoUrl: map['photoUrl'],
    );
  }
  
  // Converter de UserModel para Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'gameName': gameName,
      'whatsapp': whatsapp,
      'role': role,
      'joinDate': joinDate,
      'photoUrl': photoUrl,
    };
  }
}
