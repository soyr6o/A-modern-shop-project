import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/features/app/screens/profile/editprofile/screens/changename/changename.dart';
import 'package:appwrite2/features/app/screens/profile/editprofile/screens/changephonenumber/changephonenumber.dart';
import 'package:appwrite2/features/app/screens/profile/editprofile/screens/changeusername/changeusername.dart';
import 'package:appwrite2/features/authentication/controllers/user_controller.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final uploadImage = Get.put(UserController()).uploadImage;
    Get.put(UserController()).getProfileImage;
    final userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            MFullScreenLoader.openLoadingDialog("Loading ...");
            await userController.refreshUser();
            MFullScreenLoader.stopLoading();
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blueAccent,
                          width: 4),
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
                ),
              ),
              SizedBox(height: 6,),
              Center(child: IconButton(onPressed:uploadImage, icon: Icon(Iconsax.edit))),
              SizedBox(height: 10,),
                Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Account Setting",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Firstname",style: TextStyle(color: Colors.grey),),
                      Obx( ()=> Text("${userController.firstname}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)),
                      IconButton(onPressed: ()=> Get.to(Changename()), icon: Icon(Iconsax.arrow_right))
                    ],
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Lastname",style: TextStyle(color: Colors.grey),),
                  Obx( ()=> Text("${userController.lastname}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)),
                  IconButton(onPressed: ()=>Get.to(ChangeUserName()), icon: Icon(Iconsax.arrow_right))
                ],
              ),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Profile Setting",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("UserId",style: TextStyle(color: Colors.grey),),
                  Obx( ()=> Text("${userController.userid}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),)),
                  IconButton(onPressed: (){}, icon: Icon(Iconsax.copy))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Phone Number",style: TextStyle(color: Colors.grey),),
                  Obx( ()=> Text("${userController.phonenumber}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),)),
                  IconButton(onPressed: ()=>Get.to(ChangePhoneNumber()), icon: Icon(Iconsax.arrow_right))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Gender",style: TextStyle(color: Colors.grey),),
                  Text("Male",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                  IconButton(onPressed: (){}, icon: Icon(Iconsax.arrow_right))
                ],
              ),
                ],
              )
        ),
      ),
    );
  }
}
