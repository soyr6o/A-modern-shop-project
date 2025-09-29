import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/user/fetch_user.dart';
import 'package:appwrite2/data/repositories/user/user_repository.dart';
import 'package:appwrite2/features/authentication/models/address_model.dart';
import 'package:appwrite2/features/authentication/models/user_model.dart';
import 'package:appwrite2/utils/popups/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  final _auth = Get.find<AppwriteService>().account;
  final _table = Get.find<AppwriteService>().tables;
  final _userRepository = Get.put(UserRepository());



  Future<void> saveRecorde(AppwriteService user) async{
    try{

      final userModel = await UserModel.fromDocument(user as Document);
      UserModel usermod = UserModel(
          userId: ID.unique(),
          firstname: userModel.firstname,
          lastname: userModel.lastname,
          username: userModel.username,
          email: userModel.email,
          phonenumber: userModel.phonenumber,
          picture: userModel.picture,
      );
      await _userRepository.saveUserRepository(usermod);
  }catch(e){
      MSnackBarHelpers.errorSnackBar(title: "data no save", message: "please login or sign up in email and password");
    }
  }
  Future<void> saveAddress(AppwriteService user) async{
    try{

      final userModel = await AddressUser.fromMap(user as Map<String, dynamic>);
      final userId = await FetchUser().getUserId();
      AddressUser usermod = AddressUser(userId: userId,
          name: userModel.name,
          phoneNumber: userModel.phoneNumber,
          street: userModel.street,
          postCode: userModel.postCode,
          city: userModel.city,
          state: userModel.state,
          country: userModel.country,);
      await _userRepository.saveAddress(usermod);
    }catch(e){
      MSnackBarHelpers.errorSnackBar(title: "data no save", message: "please login or sign up in email and password");
    }
  }


  final fetchUser = FetchUser();
  var firstname = "".obs;
  var email = "".obs;
  var phonenumber = "".obs;
  var userid = "".obs;
  var lastname="".obs;


  @override
  void onInit() {
    super.onInit();
    loadUser();
    refresh();
  }

  Future<void> loadUser() async{
    final userId = await fetchUser.getUserId();
    final data = await fetchUser.getUserData(userId);
    if (data != null) {
      firstname.value = data["firstname"];
      lastname.value = data["lastname"];
      email.value = data["email"];
      phonenumber.value = data["phonenumber"];
      userid.value = data["userId"];
    }
  }

  final _storage= Get.find<AppwriteService>().storage;
  final picker = ImagePicker();

  Future<void> uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print("❌ Select the photo first.");
      return;
    }

    final userId = await FetchUser().getUserId();
    final fileId = "profile_$userId";
    final bucketId = "68ad372a00284ca04cb2";

    try {
      await _storage.getFile(bucketId: bucketId, fileId: fileId);

      await _storage.deleteFile(bucketId: bucketId, fileId: fileId);

      await _storage.createFile(
        bucketId: bucketId,
        fileId: fileId,
        file: InputFile.fromPath(path: pickedFile.path),
      );

    } catch (e) {
      if (e is AppwriteException && e.code == 404) {
        await _storage.createFile(
          bucketId: bucketId,
          fileId: fileId,
          file: InputFile.fromPath(path: pickedFile.path),
        );
        print("✅ Profile image uploaded for the first time.");
      } else {
        print("❌ Error uploading file: $e");
      }
    }
  }


  Future<ImageProvider> getProfileImage() async{
    final userId = await FetchUser().getUserId();
    final fileId = "profile_$userId";
    final bucketId = "68ad372a00284ca04cb2";
    final bytes = await _storage.getFileView(bucketId: bucketId, fileId: fileId);
    return MemoryImage(bytes);
  }

  Future<void> refreshUser() async {
    try {
      final db = Get.find<AppwriteService>();
      final user = await db.account.get();
      final userId = user.$id;
      final response = await db.tables.listRows(
        databaseId: '68c666740018d3cc0eeb',
        tableId: 'user',
        queries: [
          Query.equal('userId', userId)
        ],
      );

      if (response.rows.isNotEmpty) {
        final doc = response.rows.first.data;

        firstname.value = doc['firstname'] ?? '';
        lastname.value = doc['lastname'] ?? '';
        phonenumber.value =doc["phonenumber"] ?? "";
      }
    } catch (e) {
      print("Error refreshing user: $e");
    }
  }
  
}