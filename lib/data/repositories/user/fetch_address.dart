import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:appwrite2/utils/constants/keys.dart';

class FetchAddress{
  Future<String> getUserId() async{
    final _auth = Get.find<AppwriteService>().account;
    final user = await _auth.get();
    return user.$id;
  }

  Future<List<Map<String, dynamic>>> getUserAddress() async{
    try{
      final userId = await getUserId();
      final _tables = Get.find<AppwriteService>().tables;

      final result = await _tables.listRows(
          databaseId: MKeys.databaseIdUser,
          tableId: MKeys.tableAddress,
          queries: [Query.equal("userId", userId)],
      );

      return result.rows.map((row) => row.data).toList();
    }catch(e){
      print("Error fetching addresses: $e");
      return []; // بازگرداندن لیست خالی به جای null
    }
  }

  Future<void> updateAddress(String rowId,Map<String, dynamic> newData,) async{
    final _tables = Get.find<AppwriteService>().tables;
    await _tables.updateRow(databaseId: MKeys.databaseIdUser, tableId: MKeys.tableAddress, rowId: rowId,data: newData);
  }
  Future<void> deleteUserAddress(String rowId) async{
    final _tables = Get.find<AppwriteService>().tables;
    await _tables.deleteRow(databaseId: MKeys.databaseIdUser, tableId: MKeys.tableAddress, rowId: rowId);
  }
}