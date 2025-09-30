import 'dart:typed_data';

import 'package:appwrite2/features/app/screens/product/product.dart';
import 'package:appwrite2/features/app/screens/srote/widget/search_widget.dart';
import 'package:appwrite2/features/authentication/controllers/cartitem/cert_item_controller.dart';
import 'package:appwrite2/features/app/screens/home/productcategories/electronics.dart';
import 'package:appwrite2/features/app/screens/home/productcategories/furniture.dart';
import 'package:appwrite2/features/app/screens/home/widget/bottomcurvedclipper.dart';
import 'package:appwrite2/features/authentication/controllers/user_controller.dart';
import 'package:appwrite2/features/app/screens/home/productcategories/cloths.dart';
import 'package:appwrite2/features/app/screens/home/productcategories/shoes.dart';
import 'package:appwrite2/features/app/screens/home/productcategories/sport.dart';
import 'package:appwrite2/features/app/screens/profile/mycart/mycart.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../appwrite.dart';


class HeaderHome extends StatefulWidget {
  const HeaderHome({
    super.key,
  });

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  final appwrite = Get.find<AppwriteService>();
  late ProductSearch _productService;
  List<Map<String, dynamic>> _results = [];
  final TextEditingController _controller = TextEditingController();


  final String bucketId = '68ad372a00284ca04cb2';

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
    final userController = Get.put(UserController());
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.42,
          child: Stack(
            children: [
              ClipPath(
                clipper: BottomCurvedClipper(),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.42,
                  color: Colors.blueAccent,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -200,
                        right: -310,
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.45,
                          width: MediaQuery.sizeOf(context).width * 1.1,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0x33FFFFFF)
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: -470,
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.45,
                          width: MediaQuery.sizeOf(context).width * 1.4,
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(500) ,
                              color: Color(0x33FFFFFF)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 30,top: 30,bottom: 270),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(MText.homeAppBarTitle,style: TextStyle(color: Colors.white),),
                                  Text("${userController.firstname.value.length > 15 ? userController.firstname.value.substring(0,15) : userController.firstname}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),) ?? Text("data")
                                ],
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
                              )
                            ]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 14,left: 2),
                                  child: Text(MText.popularCategories,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Sport()));
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? MColors.black : Colors.grey.shade200,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Image.asset("assets/icons/categories/running.png"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1,),
                                        Text("Sports",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Furniture()));
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? MColors.black : Colors.grey.shade200,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Image.asset("assets/icons/categories/sofa.png"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1,),
                                        Text("Furniture",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Electronics()));
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? MColors.black : Colors.grey.shade200,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Image.asset("assets/icons/categories/electronic-devices.png"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1,),
                                        Text("Electronics",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cloths()));
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? MColors.black : Colors.grey.shade200,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Image.asset("assets/icons/categories/clothes.png"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1,),
                                        Text("Cloths",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Shoes()));
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? MColors.black : Colors.grey.shade200,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Image.asset("assets/icons/categories/sneakers.png"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1,),
                                        Text("Shoes",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
                          ? Color(0xFF3B3A3A): Colors.grey.shade200,
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
              )
            ],
          ),
        ),
        SizedBox(
          height: 140,
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
    );
  }
}
