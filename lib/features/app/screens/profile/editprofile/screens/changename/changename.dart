import 'package:appwrite2/data/repositories/user/edit_profile.dart';
import 'package:appwrite2/features/authentication/controllers/user_controller.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:appwrite2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class Changename extends StatefulWidget {
  const Changename({super.key});

  @override
  State<Changename> createState() => _ChangenameState();
}

class _ChangenameState extends State<Changename> {
  final _firstNamecontrolle = TextEditingController();
  final _lastNamecontrolle = TextEditingController();
  final editProfileData = EditProfileData();
  final formKey = GlobalKey<FormState>();
  Future<void> saveEdit() async{
    if(!formKey.currentState!.validate()){
      return;
    }
    final fname = _firstNamecontrolle.text.trim();
    final lname = _lastNamecontrolle.text.trim();
    if(fname.isNotEmpty && lname.isNotEmpty){
      await editProfileData.editName("firstname",fname);
      await editProfileData.editName("lastname",lname);
    }
  }
  @override
  void dispose() {
    _firstNamecontrolle.dispose();
    _lastNamecontrolle.dispose();
    super.dispose();
  }
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Name"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:10 ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Update your first name and last name to keep your profile accurate and personalized",style: TextStyle(color: Colors.grey),),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _firstNamecontrolle,
                  validator: (value)=> MValidator.validateEmptyText("First name", value),
                  decoration: InputDecoration(
                    label: Text("First Name"),
                    prefixIcon: Icon(Iconsax.user_edit),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _lastNamecontrolle,
                  validator: (value)=> MValidator.validateEmptyText("last name", value),
                  decoration: InputDecoration(
                    label: Text("Last Name"),
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
