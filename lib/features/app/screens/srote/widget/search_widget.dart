import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/model_product.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:appwrite2/utils/constants/keys.dart';

class ProductSearch {

  final appwrite = Get.find<AppwriteService>();

  final String databaseId = MKeys.databaseIdProducts;
  final String collectionId = MKeys.tableProducts;



  Future<List<Map<String, dynamic>>> searchProducts(String keyword) async {


    final result = await appwrite.tables.listRows(

      databaseId: databaseId,

      tableId: collectionId,

      queries: [
        Query.or([
          Query.search('name', keyword),
          Query.search('description', keyword),
        ]),
        Query.equal("isPublic", true),
      ],
    );

    return result.rows.map((doc) => doc.data).toList();
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {

    final result = await appwrite.tables.listRows(

      databaseId: databaseId,

      tableId: collectionId,
    );
    return result.rows.map((doc) => doc.data).toList();
  }

  Future<Row> getPrudact(String rowId) async {

    return await appwrite.tables.getRow(databaseId: databaseId, tableId: collectionId, rowId: rowId);

  }

  Future<void> addCard(ProductsData productItem)async{
    await appwrite.tables.createRow(databaseId: databaseId, tableId: MKeys.tableCartItems, rowId: ID.unique(), data: productItem.toMap());
  }
}
