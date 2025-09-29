import 'package:appwrite2/data/repositories/user/edit_profile.dart';
import 'package:appwrite2/features/authentication/controllers/user_controller.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:appwrite2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ChangeUserName extends StatefulWidget {
  const ChangeUserName({super.key});

  @override
  State<ChangeUserName> createState() => _ChangeUserNameState();
}

class _ChangeUserNameState extends State<ChangeUserName> {
  final _lastNameController = TextEditingController();
  final editProfileData = EditProfileData();
  final formKey3 = GlobalKey<FormState>();
  Future<void> saveEdit() async{
    if(!formKey3.currentState!.validate()){
      return;
    }
    final lname = _lastNameController.text.trim();
    if(lname.isNotEmpty){
      await editProfileData.editName("lastname",lname);
    }
  }
  @override
  void dispose() {
    _lastNameController.dispose();
    super.dispose();
  }
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Last name"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:10 ),
          child: Form(
            key: formKey3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Update your username to keep your profile accurate and personalized",style: TextStyle(color: Colors.grey),),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value)=>MValidator.validateEmptyText("last name", value),
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    label: Text("last name"),
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
    );
  }
}
