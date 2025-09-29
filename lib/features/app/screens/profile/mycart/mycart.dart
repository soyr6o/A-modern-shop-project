import 'dart:typed_data';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/saveproduct/save_service.dart';
import 'package:appwrite2/features/app/screens/product/product.dart';
import 'package:appwrite2/features/app/screens/profile/mycart/cart_check.dart';
import 'package:appwrite2/features/authentication/controllers/cartitem/cert_item_controller.dart';
import 'package:appwrite2/features/button/buttomnavigation.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

class MyCartProduct extends StatefulWidget {
  const MyCartProduct({super.key});

  @override
  State<MyCartProduct> createState() => _MyCartProductState();
}

class _MyCartProductState extends State<MyCartProduct> {
  final String databaseId = "68af28ac0026a60aa9db";
  final String cartTableId = "cart_items";
  final String bucketId = "68ad372a00284ca04cb2";

  final future = CartItem();
  late Future<List<Map<String, dynamic>>> _cartFuture;
  @override
  void initState() {
    super.initState();
    _cartFuture = future.fetchCartItem();
  }
  Future<Uint8List> getImage(String fileId) async {
    final appwrite = Get.find<AppwriteService>();
    final bytes = await appwrite.storage.getFileView(
      bucketId: "68ad372a00284ca04cb2",
      fileId: fileId,
    );
    return bytes;
  }
  Future<void> _updateQuantity(String rowId, int newQuantity) async {

    final appwrite = Get.find<AppwriteService>();
    if (newQuantity < 1) return;


    await appwrite.tables.updateRow(
      databaseId: databaseId,
      tableId: cartTableId,
      rowId: rowId,
      data: {"quantity": newQuantity},
    );
    setState(() {
      _cartFuture = future.fetchCartItem();
    });

  }

  Future<void> _deleteItem(String rowId) async {
    final appwrite = Get.find<AppwriteService>();
    await appwrite.tables.deleteRow(databaseId: databaseId, tableId: cartTableId, rowId: rowId);
    setState(() {
      _cartFuture = future.fetchCartItem();
    });
    CartItemController.instance.refreshTotals();
  }
  final controller = Get.put(CartItemController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Obx(() => SizedBox(
        width: MediaQuery.sizeOf(context).width/1.1,
        child: FloatingActionButton.extended(
            backgroundColor: Theme.brightnessOf(context) == Brightness.light ? MColors.primary : MColors.dark,
            splashColor: Colors.white, onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartCheck()));
        }, label: Text("checkout ${controller.totalPrice.value.toString()}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,fontFamily: "Poppins",color: Theme.brightnessOf(context)== Brightness.dark ? Colors.white : Colors.black),)),
      )),
      appBar: AppBar(
        title: Text("Cart",style: TextStyle(fontSize: 24),),
      ),
      body: SafeArea(
        child: FutureBuilder(future: _cartFuture, builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.none) {
            return Column(
              children: [
                Lottie.asset(MImage.loadingAnimation5),
                Text("check your internet connection",style: TextStyle(fontSize: 20,),),
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Lottie.asset(MImage.loadingAnimation5),
                  SizedBox(height: 20,),
                  Text("Error getting products !!",style: TextStyle(fontSize: 20,),),

                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      height: MediaQuery.sizeOf(context).height/2,
                      child: Lottie.asset(MImage.loadingAnimation5)),
                ),
              ],
            );
          }
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      height: MediaQuery.sizeOf(context).height/2.5,
                      child: Lottie.asset(MImage.noData2)),
                ),
                SizedBox(height: 10,),
                Text("Cart is empty",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                SizedBox(height: 10,),
                SizedBox(
                    width: 300,
                    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).brightness == Brightness.dark ? MColors.primary : MColors.dark),onPressed: ()=>Get.offAll(BottomNavigation()), child: Text("Let's fill it"))),
              ],
            );
          }
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SeeProduct($id: item["productId"].toString())));
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: FutureBuilder(
                                          future: getImage(item["mainImageId"]), builder: (context,snapshot){
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator(),);
                                        }
                                        if (snapshot.hasError) {
                                          return Center(child: Text("Error: ${snapshot.error}"),);
                                        }
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? MColors.black : Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.memory(snapshot.data!,),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.only(left: 8,right: 8,bottom: 20),
                             child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("${item['productName'].toString().length > 7 ? item['productName'].toString().substring(0, 7) : item['productName']}".toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                SizedBox(height: 16,),
                                Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   IconButton(
                                     icon: const Icon(Icons.remove),
                                     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                     onPressed: () async {
                                       _updateQuantity(item["\$id"], item["quantity"] - 1);
                                       await controller.refreshTotals();
                                     }
                                   ),
                                   Text("${item["quantity"]}"),
                                   IconButton(
                                     icon: const Icon(Icons.add),
                                     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                     onPressed: () async {
                                       _updateQuantity(item["\$id"], item["quantity"] + 1);
                                       await controller.refreshTotals();
                                     },
                                   ),
                                   IconButton(
                                     icon: const Icon(Icons.delete_outline_sharp, color: Colors.redAccent),
                                     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                     onPressed: () => _deleteItem(item["\$id"]),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                       ),
                       ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("\$${item["priceAtAdd"]}".toString(),style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        })
      ),
    );
  }
}
