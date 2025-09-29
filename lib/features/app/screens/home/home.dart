import 'dart:typed_data';
import 'dart:ui';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/model_product.dart';
import 'package:appwrite2/data/repositories/product/product_service.dart';
import 'package:appwrite2/features/app/screens/home/widget/banerslider.dart';
import 'package:appwrite2/features/app/screens/home/widget/banner.dart';
import 'package:appwrite2/features/app/screens/home/widget/headerhome.dart';
import 'package:appwrite2/features/app/screens/product/product.dart';
import 'package:appwrite2/features/authentication/controllers/cartitem/cert_item_controller.dart';
import 'package:appwrite2/features/authentication/controllers/home/homecontroller.dart';
import 'package:appwrite2/features/button/button_saveproduct.dart';
import 'package:appwrite2/features/button/wishlist_icon_buttom.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductsData>> _productState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productState = ProductService.getAllProduct();
  }
  Future<Uint8List?> getImage(String fileId) async {
    final appwrite = Get.find<AppwriteService>();
    final bytes = await appwrite.storage.getFileView(
      bucketId: "68ad372a00284ca04cb2",
      fileId: fileId,
    );
    return bytes;
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    Get.put(CartItemController());
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
                HeaderHome(),
            SizedBox(height: 20,),
            BannerWidget(),
            Center(child: Banersliderwidgetpage()),
            Padding(
              padding: const EdgeInsets.only(top: 14,left: 11,right: 10),
              child: Row(children: [
                TextButton(onPressed: () {}, child: Text("All Product",style: TextStyle(fontSize: 20,color: Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.black),)),
                Spacer(),
                TextButton(onPressed: (){}, child: Text("View All",style: TextStyle(color: Colors.blueAccent),))
              ],),
            ),
            FutureBuilder(future: _productState, builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Lottie.asset(MImage.loadingAnimation4),);
              }
              if (snapshot.hasError) {
                return Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("please connect internet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),);
              }
              if (!snapshot.hasData) {
                return Center(child: Text("no data"),);
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(child: Text("please connect internet"),);
              }
              final product = snapshot.data ?? [];
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                itemCount: product.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context,index){
                  final p = product[index];
                  return _buildProductCard(p);
                  }
              );
            })
          ],
        ),
      ),
    );
  }
  Widget _buildProductCard(ProductsData product){
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SeeProduct($id: product.id!)));
      },
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FutureBuilder(
                        future: getImage(product.mainImage), builder: (context,snapshot){
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
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButtonWishList(
                    productId: product.id!,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 80,
              left: 12,
              child: Text(product.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
            ),
            Positioned(
              bottom: 60,
              left: 12,
              child: Text(product.description.length > 20 ? product.description.substring(0,15) + "..." : product.description,style: TextStyle(),overflow: TextOverflow.ellipsis,),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(product.price.toString(),style: TextStyle(fontSize: 20),),),
            Positioned(
              bottom: -8,
                right: -6,
                child: Container(
              width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10)
                  ),
            )),
            Positioned(
              bottom: -8,
              right: -6,
              child: ButtonSaveProduct(productId: product.id.toString(), quantity: 1, priceAtAdd: product.price, productName: product.name, mainImageId: product.mainImage))
          ],
        ),
      ),
    );
  }
}



