import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/saveproduct/save_model.dart';
import 'package:appwrite2/data/repositories/product/saveproduct/save_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:appwrite2/features/authentication/controllers/cartitem/cert_item_controller.dart';

class ButtonSaveProduct extends StatelessWidget {
  String productId;
  int quantity;
  double priceAtAdd;
  String productName;
  String mainImageId;
  ButtonSaveProduct({super.key,required this.productId,required this.quantity,required this.priceAtAdd,required this.productName,required this.mainImageId});
 
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartItemController());
    final cartItem = CartItem();
    Future<void> saveProduct() async{
      final appwrite = Get.find<AppwriteService>();
      final user = await appwrite.account.get();
      final userId = user.$id;
      final save = await cartItem.creatItem(
          SaveModel(
        userId: userId,
        productId: productId,
        quantity: quantity,
        priceAtAdd: priceAtAdd,
        productName: productName,
        mainImageId: mainImageId,
      ));
    }
    return IconButton(onPressed: () async{
      await saveProduct();
      await Get.snackbar("Add to Cart", "Full success");
      await controller.refreshTotals();
    }, icon: Icon(Iconsax.add,color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,size: 25,),);
  }
}
