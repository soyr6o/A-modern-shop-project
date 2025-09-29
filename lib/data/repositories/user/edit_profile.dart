import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProfileData{

  final _appwriteService = Get.find<AppwriteService>();

  Future<void> editName(String fieldName,dynamic value) async{

    final user= await _appwriteService.account.get();
    final userId = user.$id;
    final result = await _appwriteService.tables.listRows(databaseId: "68c666740018d3cc0eeb", tableId: "user",queries: [Query.equal("userId", userId)]);
    if (result.rows.isNotEmpty) {
      final rowId = result.rows.first.$id;
       await _appwriteService.tables.updateRow(databaseId: "68c666740018d3cc0eeb", tableId: "user", rowId: rowId,data: {fieldName:value});
    }

  }
}