import 'dart:async';
import 'package:get/get.dart';
import 'package:appwrite2/utils/constants/keys.dart';
import 'package:appwrite2/data/repositories/product/saveproduct/save_service.dart';

class CartItemController extends GetxController{
  static CartItemController get instance => Get.find();

  RxInt noOfCartItem = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;

  final CartItem _cartItemService = CartItem();
  Timer? _autoRefreshTimer;
  final String databaseId = MKeys.databaseIdProducts;

  @override
  void onInit() {
    super.onInit();
    refreshTotals();
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 2), (_) => refreshTotals());
  }

  Future<void> refreshTotals() async {
    try {
      final userItems = await _cartItemService.fetchCartItem();

      final int itemCount = userItems.length;
      int totalQuantity = 0;
      double grandTotal = 0.0;

      for (final item in userItems) {
        final int quantity = (item['quantity']) is int
            ? item['quantity']
            : int.tryParse(item['quantity'].toString());
        final double priceAtAdd = (item['priceAtAdd']) is double
            ? item['priceAtAdd']
            : double.tryParse(item['priceAtAdd'].toString()) ;

        totalQuantity += quantity;
        grandTotal += priceAtAdd * quantity;
      }

      noOfCartItem.value = itemCount;
      productQuantityInCart.value = totalQuantity;
      totalPrice.value = double.parse(grandTotal.toStringAsFixed(2));
    } catch (_) {
      noOfCartItem.value = "" as int;
      productQuantityInCart.value = "" as int;
      totalPrice.value = "" as double;
    }
  }

  @override
  void onClose() {
    _autoRefreshTimer?.cancel();
    super.onClose();
  }
}