import 'package:flutter/material.dart';

class User {
  User({@required this.id, @required this.username, @required this.cartId, @required this.email, @required this.jwt});

  String id;
  String username;
  String email;
  String jwt;
  String cartId;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      jwt: json['jwt'],
      cartId: json['cartId']
    );
  }
}