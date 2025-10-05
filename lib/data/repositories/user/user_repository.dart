import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/features/authentication/models/address_model.dart';
import 'package:appwrite2/features/authentication/models/user_model.dart';
import 'package:appwrite2/utils/constants/keys.dart';
import 'package:appwrite2/utils/exceptions/appwrite_auth.dart';
import 'package:appwrite2/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:appwrite2/utils/constants/keys.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();
  final _table = Get.find<AppwriteService>().tables;


  Future<void> saveUserRepository(UserModel user) async{

    try{


      await _table.createRow(databaseId: MKeys.databaseIdUser, tableId: MKeys.tableUser, rowId: ID.unique(), data: user.toMap());


    }on AppwriteException catch(e){
      print("AppwriteException occurred: ${e.code} - ${e.message}");
      throw MAppwriteAuthException(e.code.toString()).message;
    } on PlatformException catch(e){
      print("PlatformException occurred: ${e.code} - ${e.message}");
      throw MPlatformException(e.code).message;
    }catch(e){
      print("General exception occurred: $e");
      throw "Something went wrong. Please try again";
    }

  }
  Future<void> saveAddress(AddressUser user) async{

    try{

      await _table.createRow(databaseId: MKeys.databaseIdUser, tableId: MKeys.tableAddress, rowId: ID.unique(), data: user.toMap());

    }on AppwriteException catch(e){
      print("AppwriteException occurred: ${e.code} - ${e.message}");
      throw MAppwriteAuthException(e.code.toString()).message;
    } on PlatformException catch(e){
      print("PlatformException occurred: ${e.code} - ${e.message}");
      throw MPlatformException(e.code).message;
    }catch(e){
      print("General exception occurred: $e");
      throw "Something went wrong. Please try again";
    }

  }
}