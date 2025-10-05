import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:appwrite2/utils/constants/keys.dart';

class GetCategories{

  final databaseId = MKeys.databaseIdProducts;
  final tableId = "categories";
  final appwrite = Get.find<AppwriteService>();
  Future<List<Map<String, dynamic>>> getProductsByCategory(String categoryId) async {
    final result = await appwrite.tables.listRows(
      databaseId: databaseId,
      tableId: "products",
      queries: [
        Query.equal("\$id", categoryId),
      ],
    );

    return result.rows.map((row) => row.data).toList();
  }
  Future<List<Map<String, dynamic>>> getSport() async {
    final categoriesResult = await appwrite.tables.listRows(
      databaseId: databaseId,
      tableId: "categories",
      queries: [Query.equal("name", "sports")],
    );

    List<Map<String, dynamic>> allProducts = [];

    for (final category in categoriesResult.rows) {
      final categoryId = category.$id;
      final products = await getProductsByCategory(categoryId);
      allProducts.addAll(products);
    }

    return allProducts;
  }

  Future<List<Map<String, dynamic>>> getFurniture() async {
    final categoriesResult = await appwrite.tables.listRows(
      databaseId: databaseId,
      tableId: "categories",
      queries: [Query.equal("name", "furniture")],
    );

    List<Map<String, dynamic>> allProducts = [];

    for (final category in categoriesResult.rows) {
      final categoryId = category.$id;
      final products = await getProductsByCategory(categoryId);
      allProducts.addAll(products);
    }

    return allProducts;
  }
  Future<List<Map<String, dynamic>>> getElectronics() async {
    final categoriesResult = await appwrite.tables.listRows(
      databaseId: databaseId,
      tableId: "categories",
      queries: [Query.equal("name", "electronics")],
    );

    List<Map<String, dynamic>> allProducts = [];

    for (final category in categoriesResult.rows) {
      final categoryId = category.$id;
      final products = await getProductsByCategory(categoryId);
      allProducts.addAll(products);
    }

    return allProducts;
  }
  Future<List<Map<String, dynamic>>> getClothes() async {
    final categoriesResult = await appwrite.tables.listRows(
      databaseId: databaseId,
      tableId: "categories",
      queries: [Query.equal("name", "clothes")],
    );

    List<Map<String, dynamic>> allProducts = [];

    for (final category in categoriesResult.rows) {
      final categoryId = category.$id;
      final products = await getProductsByCategory(categoryId);
      allProducts.addAll(products);
    }

    return allProducts;
  }

  Future<List<Map<String, dynamic>>> getShoes() async {
    final categoriesResult = await appwrite.tables.listRows(
      databaseId: databaseId,
      tableId: "categories",
      queries: [Query.equal("name", "shoes")],
    );

    List<Map<String, dynamic>> allProducts = [];

    for (final category in categoriesResult.rows) {
      final categoryId = category.$id;
      final products = await getProductsByCategory(categoryId);
      allProducts.addAll(products);
    }

    return allProducts;
  }

  }