import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/authentication_repositories.dart';
import 'package:appwrite2/features/authentication/controllers/user_controller.dart';
import 'package:appwrite2/utils/helpers/network_manager.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:appwrite2/utils/popups/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKy = GlobalKey<FormState>();
  final connected = Get.put(NetworkManager());
  final userController = Get.put(UserController());
  RxBool isPasswordVisible = false.obs;
  RxBool isCheckBox = false.obs;
  final localStorage = GetStorage();
  final login = Get.put(Authentication());


  @override
  void onInit() {
    email.text = localStorage.read("email") ?? "";
    password.text = localStorage.read("password") ?? "";
    super.onInit();
  }
  DateTime? lastLoginAttempt;
  Future<void> loginWithEmailAndPassword() async{
    final now = DateTime.now();


    if (lastLoginAttempt != null && now.difference(lastLoginAttempt!).inSeconds < 5) {
      MSnackBarHelpers.warningSnackBar(
        title: "Please wait",
        message: "You can try again in a few seconds.",
      );
      return;
    }

    lastLoginAttempt = now;

    try{

      if (!loginFormKy.currentState!.validate()) {
        return;
      }

      MFullScreenLoader.openLoadingDialog("Login ...");

      final connect = await connected.isConnected();
      if (!connect) {
        MFullScreenLoader.stopLoading();
        MSnackBarHelpers.warningSnackBar(title: "No internet connection");
        return;
      }
      
      if (isCheckBox.value) {
        localStorage.write("email", email.text.trim());
        localStorage.write("password", password.text.trim());
      }

      await login.loginWithEmailPassword(email.text, password.text);


      MFullScreenLoader.stopLoading();

      await login.screenRedirect();


    }on AppwriteException catch (e) {
        MSnackBarHelpers.errorSnackBar(
          title: "Error",
          message: e.message ?? "Unknown error",
        );

      MFullScreenLoader.stopLoading();

    }catch(e){
      MFullScreenLoader.stopLoading();
      MSnackBarHelpers.errorSnackBar(title: "Login filed", message: e.toString());
    }
  }

  Future<void> googleSignin() async{
    try{

      MFullScreenLoader.openLoadingDialog("Login ...");


      final connect = await connected.isConnected();
      if (!connect) {
        MFullScreenLoader.stopLoading();
        MSnackBarHelpers.warningSnackBar(title: "No internet connection");
        return;
      }


      final user = await login.loginWithGoodle();

      await userController.saveRecorde(user as AppwriteService);

      MFullScreenLoader.stopLoading();

    }catch(e){

    }
  }
}