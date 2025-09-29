import 'package:appwrite2/data/repositories/user/edit_profile.dart';
import 'package:appwrite2/features/authentication/controllers/user_controller.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:appwrite2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({super.key});

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  final _phonenumberNamecontrolle = TextEditingController();
  final editProfileData = EditProfileData();
  final formKey2 = GlobalKey<FormState>();
  Future<void> saveEdit() async{
    if(!formKey2.currentState!.validate()){
      return;
    }
    final lname = _phonenumberNamecontrolle.text.trim();
    if(lname.isNotEmpty){
      await editProfileData.editName("phonenumber",lname);
    }
  }
  @override
  void dispose() {
    _phonenumberNamecontrolle.dispose();
    super.dispose();
  }
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Username"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:10 ),
          child: Form(
            key: formKey2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Update your phone number to keep your profile accurate and personalized",style: TextStyle(color: Colors.grey),),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller:_phonenumberNamecontrolle,
                  validator: (value)=> MValidator.validateEmptyText("Phone Number", value),
                  decoration: InputDecoration(
                    label: Text("Phone Number"),
                    prefixIcon: Icon(Iconsax.user_edit),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(onPressed: () async {
                        MFullScreenLoader.openLoadingDialog("Wait for complete!");
                        await saveEdit();
                        await userController.refreshUser();
                        MFullScreenLoader.stopLoading();
                      }, child: Text("Save"))),
                )
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
