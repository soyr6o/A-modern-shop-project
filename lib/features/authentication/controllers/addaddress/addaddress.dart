import 'package:appwrite2/features/app/screens/profile/myaddress/myaddress.dart';
import 'package:appwrite2/features/authentication/models/address_model.dart';
import 'package:appwrite2/data/repositories/user/fetch_user.dart';
import 'package:appwrite2/utils/popups/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart' show UserRepository;


class AddAddress extends GetxController{
  static AddAddress get instance => Get.find();
  final userRepository = Get.put(UserRepository());
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final addressKey = GlobalKey<FormState>();

  Future<void> addAddress() async{
    if (!addressKey.currentState!.validate()) {
      return;
    };
    try {
      final userId = await FetchUser().getUserId();
      
      AddressUser user = AddressUser(
          userId: userId,
          name: name.text,
          phoneNumber: phoneNumber.text,
          street: street.text,
          postCode: postCode.text,
          city: city.text,
          state: state.text,
          country: country.text,
      );
      
      await userRepository.saveAddress(user);

      MSnackBarHelpers.successSnackBar(
        title: "Success", 
        message: "Address saved successfully!"
      );

      name.clear();
      phoneNumber.clear();
      street.clear();
      postCode.clear();
      city.clear();
      state.clear();
      country.clear();

      Get.to(MyAddress());
      
    } catch (e) {
      // نمایش پیام خطا
      MSnackBarHelpers.errorSnackBar(
        title: "Error", 
        message: "Failed to save address: $e"
      );
    }
  }
}