import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/saveproduct/save_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CartItem{

  final databaseId = "68af28ac0026a60aa9db";
  final tableId = "cart_items";
  
  final appwrite = Get.find<AppwriteService>();
  Future<void> creatItem(SaveModel data) async{
    final appwrite = Get.find<AppwriteService>();
    final user = await appwrite.account.get();
    final userId = user.$id;
    await appwrite.tables.createRow(databaseId: databaseId, tableId: tableId, rowId: ID.unique(), data: {
      "userId":userId,
      ...data.toMap(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchCartItem() async{
    final appwrite = Get.find<AppwriteService>();
    final user = await appwrite.account.get();
    final userId = user.$id;
    final result = await appwrite.tables.listRows(databaseId: databaseId, tableId: tableId,queries: [Query.equal("userId", userId)]);
    return result.rows.map((doc) => doc.data).toList();
  }
}