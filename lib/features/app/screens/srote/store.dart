import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/features/app/screens/home/widget/bottomcurvedclipper.dart';
import 'package:appwrite2/features/app/screens/product/product.dart';
import 'package:appwrite2/features/app/screens/profile/mycart/mycart.dart';
import 'package:appwrite2/features/app/screens/srote/widget/search_widget.dart';
import 'package:appwrite2/features/authentication/controllers/cartitem/cert_item_controller.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:appwrite2/utils/constants/keys.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final appwrite = Get.find<AppwriteService>();
  late ProductSearch _productService;
  List<Map<String, dynamic>> _results = [];
  final TextEditingController _controller = TextEditingController();


  final String bucketId = MKeys.bucketProducts;

  @override
  void initState() {
    super.initState();

    _productService = ProductSearch();
  }


  void _search(String keyword) async {
    final data = await _productService.searchProducts(keyword);
    setState(() {
      _results = data;
    });
  }


  Future<Uint8List?> _getProductImage(String fileId) async {
    return await appwrite.storage.getFileView(
      bucketId: bucketId,
      fileId: fileId,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: BottomCurvedClipper(),
                  child: Container(
                    height: 200,
                    color: Colors.blueAccent,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -200, // حرکت به بالا
                          right: -310, // حرکت به راست
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.45,
                            width: MediaQuery.sizeOf(context).width * 1.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0x33FFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 32,
                  left: 32,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xFF3B3A3A)
                          : Colors.grey.shade200,
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: _controller,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          prefixIcon: Icon(Iconsax.search_normal, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search, color: Colors.blue),
                            onPressed: () => _search(_controller.text),
                          ),
                          hintText: 'Search products...',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 30,
                  left: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Store",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                      ),
                      Stack(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyCartProduct()));
                          }, icon: Icon(Iconsax.shopping_cart,size: 30,color: Colors.white,)),
                          Positioned(
                            right: MediaQuery.of(context).size.width * 0.008,
                            top: MediaQuery.of(context).size.height * 0.004,
                            child: CircleAvatar(
                                backgroundColor: Theme.of(context).brightness == Brightness.dark ? Color(0xAAFFFFFF)  : Color(0x9A000000),
                                radius: 8,
                                child: Obx(
                                      ()=> Text(CartItemController.instance.noOfCartItem.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness == Brightness.light ? MColors.light : MColors.dark),),
                                )),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final product = _results[index];
                final fileId = product['mainImage'] ?? '';

                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeProduct($id: product['\$id'])));
                  },
                  child: Card(
                    color: Colors.white60,
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FutureBuilder<Uint8List?>(
                              future: _getProductImage(fileId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  );
                                }
                                if (!snapshot.hasData || snapshot.hasError) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                                  );
                                }
                                return Image.memory(
                                  snapshot.data!,
                                  width: 100,
                                  height: 100,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  product['description'] ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "price: ${product['price'] ?? ''}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          ],
        ),
      ),
    );
  }
}
