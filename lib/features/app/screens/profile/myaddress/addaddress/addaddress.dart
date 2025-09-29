import 'package:appwrite2/features/authentication/controllers/addaddress/addaddress.dart';
import 'package:appwrite2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddAddres extends StatelessWidget {
  const AddAddres({super.key});

  @override
  Widget build(BuildContext context) {
    final addAddress = Get.put(AddAddress());
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Address"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: addAddress.addressKey,
            child: ListView(
              children: [
                TextFormField(
                  validator: (value)=>MValidator.validateEmptyText("Name", value),
                  controller: addAddress.name,
                  decoration: InputDecoration(
                    label: Text("Name"),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                SizedBox(height: 14,),
                TextFormField(
                  validator: (value)=>MValidator.validatePhoneNumber(value),
                  controller: addAddress.phoneNumber,
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
                        controller: addAddress.street,
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
                        controller: addAddress.postCode,
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
                        controller: addAddress.city,
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
                        controller: addAddress.state,
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
                  controller: addAddress.country,
                  decoration: InputDecoration(
                      label: Text("Country"),
                      prefixIcon: Icon(Symbols.public)
                  ),
                ),
                SizedBox(height: 24,),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      onPressed: addAddress.addAddress,
                      child: Text("save"),
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
