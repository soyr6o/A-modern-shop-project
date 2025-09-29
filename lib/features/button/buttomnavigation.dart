import 'package:appwrite2/features/app/screens/home/home.dart';
import 'package:appwrite2/features/app/screens/profile/profile.dart';
import 'package:appwrite2/features/app/screens/srote/store.dart';
import 'package:appwrite2/features/app/screens/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationController());
    return Scaffold(
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
            elevation: 0,
            indicatorColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade700
                : Colors.grey.shade300,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black54 : Colors.grey.shade200,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index){
              controller.selectedIndex.value = index;
            },
            destinations: [
          NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
          NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
          NavigationDestination(icon: Icon(Iconsax.heart), label: "WishList"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
        ]),
      )
    );
  }
}

class BottomNavigationController extends GetxController{
  RxInt selectedIndex = 0.obs;
  List<Widget> screens = [HomeScreen(),StoreScreen(),WishListScreen(),ProfileScreen(),];
}