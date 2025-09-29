import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/authentication_repositories.dart';
import 'package:appwrite2/data/repositories/user/user_repository.dart';
import 'package:appwrite2/features/authentication/models/user_model.dart';
import 'package:appwrite2/features/authentication/screens/signup/verify/verify.dart';
import 'package:appwrite2/utils/constants/keys.dart';
import 'package:appwrite2/utils/helpers/network_manager.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:appwrite2/utils/popups/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();
  RxBool isPasswordVisible = false.obs;
  RxBool isPrivacyPolicy = false.obs;

  final _authRepository = Get.put(Authentication());
  final signUpFormKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  DateTime? lastLoginAttempt;

  Future<void> registerUser() async{
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

      // Form Validation
      if (!signUpFormKey.currentState!.validate()) {
        return;
      };

      //check privacy policy
      if (!isPrivacyPolicy.value) {
        MSnackBarHelpers.warningSnackBar(title: "Accept privacy policy",message: "In order to creat account,you must have to read and accept the privacy policy & terms of use");
        return;
      }


      // Start Loading
      MFullScreenLoader.openLoadingDialog("we are processing your information... ");



      //check internet connection
      bool isConnected = await Get.put(NetworkManager()).isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        MSnackBarHelpers.warningSnackBar(title: "No internet connection");
        return;
      }


      final user = await _authRepository.registerUser(email.text.trim(), password.text.trim());


      final appwriteUserId = user.user.$id;
      UserModel userModel = UserModel(
        userId: appwriteUserId,
        firstname: firstName.text.trim(),
          lastname: lastName.text.trim(),
          username: "${firstName.text} ${lastName.text}",
          email: email.text.trim(),
          phonenumber: phoneNumber.text.trim(),
          picture: "",
      );

      final userRepository = Get.put(UserRepository());
      try {
        await userRepository.saveUserRepository(userModel);
        print("User data saved successfully to database");
      } catch (e) {
        print("Error saving user data: $e");
        MFullScreenLoader.stopLoading();
        MSnackBarHelpers.errorSnackBar(
          title: "Database Error",
          message: "Failed to save user data: ${e.toString()}"
        );
        return;
      }



      MSnackBarHelpers.successSnackBar(title: "congratulation ",message: "your account has been created! verify email to continue");




      MFullScreenLoader.stopLoading();

      Get.to(Verify(email: email.text,));
    }on AppwriteException catch (e) {
      MFullScreenLoader.stopLoading();
      if (e.code == 409) {
        MSnackBarHelpers.warningSnackBar(
          title: "User already exists",
          message: "An account with this email already exists.",
        );
      } else if (e.code == 400) {
        MSnackBarHelpers.warningSnackBar(
          title: "Invalid Input",
          message: "Invalid email or password format.",
        );
      }else if (e.code == 429) {
        MSnackBarHelpers.warningSnackBar(
          title: "Invalid Input",
          message: "Error, The number of requests exceeds the allowed limit. Please wait a few minutes.",
        );
        print(e.message);
      } else {
        MSnackBarHelpers.errorSnackBar(
          title: "Registration Error",
          message: e.message ?? "An error occurred during registration.",
        );
      }
    }catch(e){
      MFullScreenLoader.stopLoading();
      MSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }
  }
}