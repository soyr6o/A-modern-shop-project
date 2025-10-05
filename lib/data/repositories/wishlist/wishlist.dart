import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/model_product.dart';
import 'package:appwrite2/data/repositories/product/product_service.dart';
import 'package:get/get.dart';
import 'package:appwrite2/utils/constants/keys.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

class WishListData{


  final appwrite = Get.find<AppwriteService>();

  final databaseId = MKeys.databaseIdUser;
  final tableId = "ecommercedb";
  Future<bool> toggleWishlist(String productId, bool newValue) async {
    try {
      final user = await appwrite.account.get();
      final userId = user.$id;

      final existingRows = await appwrite.tables.listRows(
        databaseId: databaseId,
        tableId: tableId,
        queries: [
          Query.equal('userId', userId),
          Query.equal('productId', productId),
        ],
      );

      if (existingRows.rows.isEmpty) {
        await appwrite.tables.createRow(
          databaseId: databaseId,
          tableId: tableId,
          rowId: ID.unique(),
          data: {
            "userId": userId,
            "productId": productId,
            "isInWishlist": newValue,
          },
        );
      } else {
        final docId = existingRows.rows.first.$id;
        await appwrite.tables.updateRow(
          databaseId: databaseId,
          tableId: tableId,
          rowId: docId,
          data: {
            "isInWishlist": newValue,
          },
        );
      }
      return true;
    } catch (e) {
      print("[WishListData] toggleWishlist error: $e");
      return false;
    }
  }
  Future<bool> isProductInWishlist(String productId) async {
    try {
      final user = await appwrite.account.get();
      final userId = user.$id;

      final existingRows = await appwrite.tables.listRows(
        databaseId: databaseId,
        tableId: tableId,
        queries: [
          Query.equal('userId', userId),
          Query.equal('productId', productId),
          Query.equal('isInWishlist', true),
        ],
      );

      return existingRows.rows.isNotEmpty;
    } catch (e) {
      print("[WishListData] isProductInWishlist error: $e");
      return false;
    }
  }

  Future<List<ProductsData>> getWishlistProducts() async {
    try {
      final user = await appwrite.account.get();
      final userId = user.$id;

      final result = await appwrite.tables.listRows(
        databaseId: databaseId,
        tableId: tableId,
        queries: [
          Query.equal('userId', userId),
          Query.equal('isInWishlist', true),
        ],
      );

      final productIds = result.rows.map((r) => r.data['productId'].toString()).whereType<String>().toList();

      List<ProductsData> products = [];
      for (final id in productIds) {
        try {
          final p = await ProductService.getProductById(id);
          products.add(p);
        } catch (e) {
          // ignore missing product errors, continue others
          print('[WishListData] getWishlistProducts product fetch error for $id: $e');
        }
      }
      return products;
    } catch (e) {
      print('[WishListData] getWishlistProducts error: $e');
      return [];
    }
  }

}