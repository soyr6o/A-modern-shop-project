import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart' as models show Session;
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/features/authentication/screens/login/login.dart';
import 'package:appwrite2/features/authentication/screens/signup/verify/verify.dart';
import 'package:appwrite2/features/authentication/screens/welcome/welcome.dart';
import 'package:appwrite2/features/button/buttomnavigation.dart';
import 'package:appwrite2/utils/exceptions/appwrite_auth.dart';
import 'package:appwrite2/utils/exceptions/platform_exceptions.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Authentication extends GetxController{
  static Authentication get instance => Get.find();
  final storage = GetStorage();
  final _auth = Get.find<AppwriteService>().account;


  @override
  void onReady() {
    FlutterNativeSplash.remove();

    screenRedirect();
  }
  Future<void> screenRedirect() async {
    try {
      final user = await _auth.get(); // حتماً await

      if (user.emailVerification) { // یا emailVerified بسته به SDK
        // ایمیل وریفای شده
        Get.offAll(() => BottomNavigation());
      } else {
        // هنوز وریفای نشده
        Get.to(() => Verify(email: user.email));
      }
    } catch (e) {
      // وقتی کاربر لاگین نیست یا Session نداره
      storage.writeIfNull("isFirstTime", true);
      storage.read("isFirstTime") == true
          ? Get.to(() => WelcomeScreens())
          : Get.to(() => LoginScreens());
    }
  }

  Future<AppwriteUserCredential> registerUser(String email, String password) async {
    try{

      final user = await _auth.create(
        userId: ID.unique(),
        email: email.trim(),
        password: password.trim(),
      );

      final session = await _auth.createEmailPasswordSession(
        email: email,
        password: password,
      );

      return AppwriteUserCredential(session: session,user: user );
    } on AppwriteException catch (e) {
      print("Appwrite error code=${e.code}, message=${e.message}");
      if (e.code == 409) {
        throw "A user with this email already exists.";
      } else if (e.code == 400) {
        throw "Invalid email or password format.";
      } else {
        throw MAppwriteAuthException(e.code.toString()).message;
      }

    }  on PlatformException catch(e){
      throw MPlatformException(e.code).message;
    }catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  Future loginWithEmailPassword(String email, String password) async {
    try{

      await _auth.createEmailPasswordSession(email: email, password: password);
    }  on AppwriteException catch (e) {
      print("Appwrite error code=${e.code}, message=${e.message}");
      if (e.code == 409) {
        throw "A user with this email already exists.";
      } else if (e.code == 400) {
        throw "Invalid email or password format.";
      } else if (e.code == 401) {
        throw "Incorrect email or password.";
      } else {
        throw MAppwriteAuthException(e.code.toString()).message;
      }
    }  on PlatformException catch(e){
      throw MPlatformException(e.code).message;
    }catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  Future<models.Session?> loginWithGoodle() async {
    try{

      final session = await _auth.createOAuth2Session(provider: OAuthProvider.google,scopes: ['profile', 'email'],);
      return session;

    }  on AppwriteException catch (e) {
      print("Appwrite error code=${e.code}, message=${e.message}");
      if (e.code == 409) {
        throw "A user with this email already exists.";
      } else if (e.code == 400) {
        throw "Invalid email or password format.";
      } else if (e.code == 401) {
        throw "Incorrect email or password.";
      } else {
        throw MAppwriteAuthException(e.code.toString()).message;
      }
    }  on PlatformException catch(e){
      throw MPlatformException(e.code).message;
    }catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  Future<void> sendEmailVerify() async{
    try{

      await _auth.createVerification(url: "https://atls.appwrite.network/verify.html");
    }  on AppwriteException catch (e) {
      print("Appwrite error code=${e.code}, message=${e.message}");
      if (e.code == 409) {
        throw "A user with this email already exists.";
      } else if (e.code == 400) {
        throw "Invalid email or password format.";
      } else if (e.code == 401) {
        throw MAppwriteAuthException("First, log in to your account and then check your email.");
      }else {
        throw MAppwriteAuthException(e.code.toString()).message;
      }

    }  on PlatformException catch(e){
      throw MPlatformException(e.code).message;
    }catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  Future<void> logout() async{
    try{
      MFullScreenLoader.openLoadingDialog("log out...");
      await _auth.deleteSession(sessionId: "current");
      MFullScreenLoader.stopLoading();
    }  on AppwriteException catch (e) {
        throw MAppwriteAuthException(e.code.toString()).message;
      } on PlatformException catch(e){
      throw MPlatformException(e.code).message;
    }catch(e){
      throw "Something went wrong. Please try again";
    }
  }
}