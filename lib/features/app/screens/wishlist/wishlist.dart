import 'dart:typed_data';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/model_product.dart';
import 'package:appwrite2/data/repositories/wishlist/wishlist.dart';
import 'package:appwrite2/features/app/screens/product/product.dart';
import 'package:appwrite2/features/button/wishlist_icon_buttom.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  
  late Future<List<ProductsData>> wishList;
  final _wishlist = Get.find<WishListData>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wishList = _wishlist.getWishlistProducts();
  }
  Future<Uint8List> getImage(String fileId) async {
    final appwrite = Get.find<AppwriteService>();
    final bytes = await appwrite.storage.getFileView(
      bucketId: "68ad372a00284ca04cb2",
      fileId: fileId,
    );
    return bytes;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Wish List",style: TextStyle(fontSize: 20),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon: Icon(Iconsax.add)),
          )
        ],
      ),
      body: ListView(
        children: [
          FutureBuilder(future: wishList, builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Column(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height/12,),
                  Lottie.asset(MImage.pencilAnimation),
                  Text("Loading Wish List ...",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              );
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height/12,),
                  Lottie.asset(MImage.pencilAnimation),
                  Text("Error in receiving information!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              );
            }
            final data = snapshot.data ?? [];
            if (data.isEmpty) {
              return Column(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height/12,),
                  Lottie.asset(MImage.pencilAnimation),
                  Text("The wishlist is empty.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              );
            }
              return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context,index){
                    final p = data[index];
                    return _buildProductCard(p);
                  }
              );
          }),
        ],
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
                  right: 0, // کمی فاصله از راست
                  top: 0,   // کمی فاصله از بالا
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
              child: IconButton(onPressed: (){}, icon: Icon(Iconsax.add,color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,size: 25,),),)
          ],
        ),
      ),
    );
  }
}
