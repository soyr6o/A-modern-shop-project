import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';import 'appwrite.dart';
import 'data/repositories/authentication_repositories.dart';
import 'data/repositories/wishlist/wishlist.dart';

void main() async{
 final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

 await GetStorage.init();

  await AppwriteService().init().then((service) {
    Get.put(service);
    Get.put(Authentication());
    Get.put(WishListData());
  });

  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MAppTheme.lightTheme,
      darkTheme: MAppTheme.darkTheme,
      home: Scaffold(
        body: Center(
          child: Lottie.asset(MImage.loadingAnimation2),
        ),
      ),
    );
  }
}
