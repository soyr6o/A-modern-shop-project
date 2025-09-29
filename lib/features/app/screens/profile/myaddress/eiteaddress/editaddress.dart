import 'package:appwrite2/data/repositories/user/fetch_address.dart';
import 'package:appwrite2/features/authentication/controllers/user_controller.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:appwrite2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_symbols_icons/symbols.dart';

class EditAddress extends StatefulWidget {
  String rowId;
  EditAddress({super.key,required this.rowId});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final streetController = TextEditingController();
  final postCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final updateAddressData = FetchAddress();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    streetController.dispose();
    postCodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
  }
  Future<void> updateAddress() async{
    if (!formkey.currentState!.validate()) {
      return;
    }
    final name = nameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();
    final street = streetController.text.trim();
    final postCode = postCodeController.text.trim();
    final city = cityController.text.trim();
    final state = stateController.text.trim();
    final country = countryController.text.trim();
    if(name.isNotEmpty && phoneNumber.isNotEmpty && street.isNotEmpty && postCode.isNotEmpty && city.isNotEmpty && state.isNotEmpty && country.isNotEmpty){
      await updateAddressData.updateAddress(widget.rowId, {"name":name},);
      await updateAddressData.updateAddress(widget.rowId, {"phoneNumber":phoneNumber},);
      await updateAddressData.updateAddress(widget.rowId, {"street":street},);
      await updateAddressData.updateAddress(widget.rowId, {"postCode":postCode},);
      await updateAddressData.updateAddress(widget.rowId, {"city":city},);
      await updateAddressData.updateAddress(widget.rowId, {"state":state},);
      await updateAddressData.updateAddress(widget.rowId, {"country":country},);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Address"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                TextFormField(
                  validator: (value)=>MValidator.validateEmptyText("Name", value),
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text("Name"),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                SizedBox(height: 14,),
                TextFormField(
                  validator: (value)=>MValidator.validatePhoneNumber(value),
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    label: Text("Phone Number"),
                    prefixIcon: Icon(Iconsax.mobile4),
                  ),
                ),
                SizedBox(height: 14,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160,
                      child: TextFormField(
                        validator: (value)=>MValidator.validateEmptyText("Street", value),
                        controller: streetController,
                        decoration: InputDecoration(
                            label: Text("Street"),
                            prefixIcon: Icon(Symbols.signpost)
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: TextFormField(
                        validator: (value)=>MValidator.validateEmptyText("Post Code", value),
                        controller: postCodeController,
                        decoration: InputDecoration(
                            label: Text("Post Code"),
                            prefixIcon: Icon(Symbols.pin)
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160,
                      child: TextFormField(
                        validator: (value)=>MValidator.validateEmptyText("city", value),
                        controller: cityController,
                        decoration: InputDecoration(
                            label: Text("City"),
                            prefixIcon: Icon(Symbols.location_city)
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: TextFormField(
                        validator: (value)=>MValidator.validateEmptyText("state", value),
                        controller: stateController,
                        decoration: InputDecoration(
                            label: Text("State"),
                            prefixIcon: Icon(Symbols.map)
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14,),
                TextFormField(
                  validator: (value)=>MValidator.validateEmptyText("country", value),
                  controller: countryController,
                  decoration: InputDecoration(
                      label: Text("Country"),
                      prefixIcon: Icon(Symbols.public)
                  ),
                ),
                SizedBox(height: 24,),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                    onPressed: () async {
                      MFullScreenLoader.openLoadingDialog("save data...");
                      await updateAddress();
                      MFullScreenLoader.stopLoading();
                    },
                    child: Text("save"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      onPressed: () async {
                        MFullScreenLoader.openLoadingDialog("delete data...");
                        await updateAddressData.deleteUserAddress(widget.rowId);
                        MFullScreenLoader.stopLoading();
                        Navigator.pop(context);
                      },
                      child: Text("DELETE"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
