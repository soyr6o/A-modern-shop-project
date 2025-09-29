import 'package:appwrite2/data/repositories/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconButtonWishList extends StatefulWidget {
  final String productId;

  const IconButtonWishList({
    super.key,
    required this.productId,
  });

  @override
  State<IconButtonWishList> createState() => _IconButtonWishListState();
}

class _IconButtonWishListState extends State<IconButtonWishList> {
  bool isInWishlist = false;
  final wishlistData = WishListData();

  @override
  void initState() {
    super.initState();
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    // این متد باید توی کلاس WishListData پیاده‌سازی شده باشه
    final inWishlist = await wishlistData.isProductInWishlist(widget.productId);
    setState(() {
      isInWishlist = inWishlist;
    });
  }

  void _toggleWishlist() async {
    final newState = !isInWishlist;
    setState(() => isInWishlist = newState);
    final ok = await wishlistData.toggleWishlist(widget.productId, newState);
    if (!ok) {
      // revert UI on failure
      setState(() => isInWishlist = !newState);
      Get.snackbar('Wishlist', 'Error registering interest. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleWishlist,
      icon: Icon(
        isInWishlist ? Icons.favorite : Icons.favorite_border,
        color: isInWishlist ? Colors.red : Colors.grey,
      ),
      iconSize: 24.0,
      padding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );

  }
}
