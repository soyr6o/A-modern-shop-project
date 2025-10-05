import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/model_product.dart';
import 'package:get/get.dart';
import 'package:appwrite2/utils/constants/keys.dart';


class ProductService{
  static final databaseId=MKeys.databaseIdProducts;
  static final tableId =MKeys.tableProducts;
  static final bucketId=MKeys.bucketProducts;


  static Future<ProductsData> creatProduct(String userId,ProductsData data) async{
    final AppwriteService appwrite = Get.find();
    final result = await appwrite.tables.createRow(databaseId: databaseId, tableId: tableId, rowId: ID.unique(), data: {
      "userId":userId,
      ...data.toMap(),
    });
    return ProductsData.fromMap(result.data,$id:result.$id);
  }
  static Future<String> uploadImage(File file) async{
    final AppwriteService appwrite = Get.find();
    final result = await appwrite.storage.createFile(bucketId: bucketId, fileId: ID.unique(), file: InputFile.fromPath(path: file.path));
    return result.$id;
  }
  static Future<List<String>> uploadMulty(List<File> files) async{
    List<String> filesId = [];
    for(File file in files){
      final fileId = await uploadImage(file);
      filesId.add(fileId);
    }
    return filesId;
  }

  static Future<List<ProductsData>> getProduct(String userId) async {
    final AppwriteService appwrite = Get.find();
    final product = await appwrite.tables.listRows(databaseId: databaseId, tableId: tableId,
        queries: [
          Query.equal("userId", userId),
          Query.equal("isPublic", true),
        ]);
    return product.rows.map((e)=> ProductsData.fromMap(e.data,$id:e.$id)).toList();
  }
  static Future<ProductsData> updateProduct(String rowId,ProductsData product) async{
    final AppwriteService appwrite = Get.find();
    final doc = await appwrite.tables.updateRow(databaseId: databaseId, tableId: tableId, rowId: rowId,
        data: product.toMap());
    return ProductsData.fromMap(doc.data,$id:doc.$id);
  }

  static Future<List<ProductsData>> getAllProduct() async{
    final AppwriteService appwrite = Get.find();
    final product = await appwrite.tables.listRows(databaseId: databaseId, tableId: tableId,
        queries: [
          Query.equal("isPublic", true)
        ]);
    return product.rows.map((e)=>ProductsData.fromMap(e.data,$id:e.$id)).toList();
  }

  static Future<ProductsData> getProductById(String id) async{
    final AppwriteService appwrite = Get.find();
    final product = await appwrite.tables.getRow(databaseId: databaseId, tableId: tableId, rowId: id);
    return ProductsData.fromMap(product.data,$id:product.$id);
  }
}