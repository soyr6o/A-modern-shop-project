import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FetchUser{
  
  Future<String> getUserId() async{
    final _auth = Get.find<AppwriteService>().account;
    final user = await _auth.get();
    return user.$id;
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async{
    try{
      final _tables = Get.find<AppwriteService>().tables;
      final result = await _tables.listRows(databaseId: "68c666740018d3cc0eeb", tableId: "user",queries: [Query.equal("userId", userId)]);
      if (result.rows.isNotEmpty) {
        return result.rows.first.data;
      }
      return null;
    }catch(e){
      print(e);
      return null;
    }
  }
}