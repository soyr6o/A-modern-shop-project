import 'dart:typed_data';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/model_product.dart';
import 'package:appwrite2/data/repositories/product/product_service.dart';
import 'package:appwrite2/features/button/button_savep.dart';
import 'package:appwrite2/features/button/button_saveproduct.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/constants/keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class SeeProduct extends StatefulWidget {
  String $id;
  SeeProduct({super.key,required this.$id});

  @override
  State<SeeProduct> createState() => _SeeProductState();
}

class _SeeProductState extends State<SeeProduct> {

  late Future<ProductsData> _productState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productState = ProductService.getProductById(widget.$id);
  }
  final appwrite = Get.find<AppwriteService>();
  Future<Uint8List?> getImage(String fileId) async{
    final result = await appwrite.storage.getFileView(bucketId: MKeys.bucketProducts, fileId: fileId);
    return result;
  }
  Future<List<Uint8List?>> getMultiImages(List<String> fileIds) async {
    List<Uint8List?> images = [];

    for (String id in fileIds) {
      final img = await getImage(id);
      images.add(img);
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: SafeArea(
          child: FutureBuilder(future: _productState, builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Lottie.asset(MImage.loadingAnimation5),);
          }
          final product = snapshot.data!;
          final mainImage = product.mainImage;
          final gallery = product.gallery;
          return SingleChildScrollView(
            padding: EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<List<Uint8List?>>(future: getMultiImages(gallery), builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Lottie.asset(MImage.loadingAnimation5),
                      );
                  }
                  if (snapshot.hasError) {
                    return Text('error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No photo available");
                  }
                final image = snapshot.data!;
                  return  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: image.length,
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        final img = image[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(10),
                            ),
                              child: img != null
                                  ? Image.memory(img,)
                                  : const ColoredBox(color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 16,top: 16),
                  child: Text("\$${product.price.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,top: 16,bottom: 32,right: 16),
                  child: Text(product.description,style: TextStyle(fontWeight: FontWeight.bold,height: 1.8),),
                ),
                Center(child: ButtonAddProduct(productId: widget.$id, quantity: 1, priceAtAdd: product.price, productName: product.name, mainImageId: product.mainImage)),
              ],
            ),
          );
          }),
        ),
      );
  }
}
