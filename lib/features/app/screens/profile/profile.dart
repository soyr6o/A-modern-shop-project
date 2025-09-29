import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/authentication_repositories.dart';
import 'package:appwrite2/features/app/screens/home/widget/bottomcurvedclipper.dart';
import 'package:appwrite2/features/app/screens/profile/editprofile/editprofile.dart';
import 'package:appwrite2/features/app/screens/profile/myaddress/myaddress.dart';
import 'package:appwrite2/features/app/screens/profile/mycart/mycart.dart';
import 'package:appwrite2/features/authentication/controllers/user_controller.dart';
import 'package:appwrite2/features/authentication/screens/login/login.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final _auth = Get.find<AppwriteService>().account;
    final logout = Get.put(Authentication());
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
        Container(
        height: MediaQuery.sizeOf(context).height * 0.25,
        child: Stack(
          children: [
            ClipPath(
              clipper: BottomCurvedClipper(),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.23,
                color: Colors.blueAccent,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -200,
                      right: -310,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.45,
                        width: MediaQuery.sizeOf(context).width * 1.1,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x33FFFFFF)
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: -470,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.45,
                        width: MediaQuery.sizeOf(context).width * 1.4,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(500) ,
                            color: Color(0x33FFFFFF)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: MediaQuery.sizeOf(context).width/2.8,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueAccent, width: 4),
                ),
                child: FutureBuilder<ImageProvider>(future: UserController.instance.getProfileImage(), builder: (context , snapshot) {
                  if (snapshot == null) {
                    return CircleAvatar(
                      radius: 60,
                      child: Icon(Icons.person),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircleAvatar(
                      radius: 60,
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return CircleAvatar(
                      radius: 60,
                      child: Icon(Icons.person),
                    );
                  }
                  return CircleAvatar(
                    radius: 60,
                    backgroundImage: snapshot.data!,
                  );
                })
              ),
            )
          ],
        ),
      ),
            Padding(
              padding: const EdgeInsets.only(left: 8,top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Personal Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    subtitle: Obx( ()=> Text(controller.email.toString(),style: TextStyle(fontSize: 16),)),
                    trailing: IconButton(onPressed: ()=>Get.to(EditProfileScreen()), icon: Icon(Iconsax.edit)),
                  ),
                  ListTile(
                    title: Text("Account Setting",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyAddress()));
                    },
                    child: ListTile(
                      leading: Icon(Iconsax.safe_home),
                      title: Text("My Address",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      subtitle: Text("Set shopping delivery addresses"),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyCartProduct()));
                    },
                    child: ListTile(
                      leading: Icon(Iconsax.shopping_cart),
                      title: Text("My Cart",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      subtitle: Text("Add, remove products and move to checkout"),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Iconsax.box_tick),
                    title: Text("My Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    subtitle: Text("In-progress and Completed Orders"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 18),
                    child: SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(onPressed: () async {
                          MFullScreenLoader.openLoadingDialog("log out...");
                          await logout.logout();
                          MFullScreenLoader.stopLoading();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreens()));
                        }, child: Text("Logout"))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
