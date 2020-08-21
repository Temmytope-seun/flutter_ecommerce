import 'package:flutter/animation.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState{
  AppState({@required this.user, @required this.products, @required this.cartProducts});

  final User user;
  final List<Product> products;
  final List<Product> cartProducts;

  factory AppState.initial() {
    return AppState(
      user: null,
      products: [],
      cartProducts: [],
    );
  }
}