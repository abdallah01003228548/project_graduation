import 'package:flutter/material.dart';

abstract class AppIcons {
  // Navigation
  static const IconData home = Icons.home_outlined;
  static const IconData homeFilled = Icons.home;

  static const IconData favorite = Icons.favorite_border_outlined;
  static const IconData favoriteFilled = Icons.favorite;

  static const IconData cart = Icons.shopping_cart_outlined;
  static const IconData cartFilled = Icons.shopping_cart;

  static const IconData person = Icons.person_outline;
  static const IconData personFilled = Icons.person;

  // Authentication
  static const IconData email = Icons.email_outlined;
  static const IconData password = Icons.lock_outline;
  static const IconData visibility = Icons.visibility_outlined;
  static const IconData visibilityOff = Icons.visibility_off_outlined;

  // Search
  static const IconData search = Icons.search;
  static const IconData filter = Icons.tune;

  // Product
  static const IconData add = Icons.add;
  static const IconData remove = Icons.remove;
  static const IconData delete = Icons.delete_outline;

  // Navigation
  static const IconData back = Icons.arrow_back_ios_new;
  static const IconData forward = Icons.arrow_forward_ios;
  static const IconData close = Icons.close;

  // Status
  static const IconData emptyCart = Icons.remove_shopping_cart_outlined;
  static const IconData emptyFavorite = Icons.favorite_border;

  // Misc
  static const IconData star = Icons.star;
  static const IconData starBorder = Icons.star_border;
  static const IconData check = Icons.check;
}