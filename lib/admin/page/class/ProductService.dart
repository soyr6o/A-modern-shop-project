import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/admin/page/class/prudact.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:appwrite2/utils/constants/keys.dart';


class ProductServic{
  static final databaseId=MKeys.databaseIdProducts;
  static final tableId =MKeys.tableProducts;
  static final bucketId=MKeys.bucketProducts;


  static Future<Products> creatProduct(String userId,Products data) async{
    final AppwriteService appwrite = Get.find();
    final result = await appwrite.tables.createRow(databaseId: databaseId, tableId: tableId, rowId: ID.unique(), data: {
      "userId":userId,
      ...data.toMap(),
    });
    return Products.fromMap(result.data,$id:result.$id);
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

  static Future<List<Products>> getProduct(String userId) async {
    final AppwriteService appwrite = Get.find();
    final product = await appwrite.tables.listRows(databaseId: databaseId, tableId: tableId,
    queries: [
      Query.equal("userId", userId),
      Query.equal("isPublic", true),
    ]);
    return product.rows.map((e)=> Products.fromMap(e.data,$id:e.$id)).toList();
  }
  static Future<Products> updateProduct(String rowId,Products product) async{
    final AppwriteService appwrite = Get.find();
    final doc = await appwrite.tables.updateRow(databaseId: databaseId, tableId: tableId, rowId: rowId,
    data: product.toMap());
    return Products.fromMap(doc.data,$id:doc.$id);
  }

  static Future<List<Products>> getAllProduct() async{
    final AppwriteService appwrite = Get.find();
    final product = await appwrite.tables.listRows(databaseId: databaseId, tableId: tableId,
    queries: [
      Query.equal("isPublic", true)
    ]);
    return product.rows.map((e)=>Products.fromMap(e.data,$id:e.$id)).toList();
  }
}