import 'package:flutter/material.dart';

class WishlistModel extends ChangeNotifier {
  List<WishlistItem> _wishlistItems = [];

  List<WishlistItem> get wishlistItems => _wishlistItems;

  void addItemToWishlist(WishlistItem item) {
    bool itemExists = false;

    for (WishlistItem wishlistItem in _wishlistItems) {
      if (wishlistItem.text == item.text) {
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      _wishlistItems.add(item);
      notifyListeners();
    }
  }

  void removeFromWish(WishlistItem wish) {
    _wishlistItems.remove(wish);
    notifyListeners();
  }


}

class WishlistItem {
  final int harga;
  final String img;
  final String text;
  final String subtext;

  WishlistItem({
    required this.harga,
    required this.img,
    required this.text,
    required this.subtext,
  });
}
