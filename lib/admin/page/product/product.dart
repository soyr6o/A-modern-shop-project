// import 'dart:typed_data';
//
// import 'package:appwrite2/admin/page/class/ProductService.dart';
// import 'package:appwrite2/admin/page/class/prudact.dart';
// import 'package:appwrite2/appwrite.dart';
// import 'package:flutter/material.dart';
//
// class Product extends StatefulWidget {
//   String userId;
//   Product({super.key,required this.userId});
//
//   @override
//   State<Product> createState() => ProductState();
// }
//
// class ProductState extends State<Product> {
//
//   late Future<List<Products>> _productState;
//
//   @override
//   void initState() {
//      // TODO: implement initState
//     super.initState();
//     _productState=ProductService.getProduct(widget.userId);
//   }
//
//   Future<Uint8List?> getmainImage(String fileId) async{
//     final result = await AppwriteServise.storage.getFileView(bucketId: "68ad372a00284ca04cb2", fileId: fileId);
//     return result;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: FutureBuilder(future: _productState, builder: (context,snapshot){
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator(),);
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text("error: ${snapshot.error}"),);
//           }
//           final products = snapshot.data ?? [];
//           return GridView.builder(
//             itemCount: products.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//             childAspectRatio: 0.6,
//           ), itemBuilder: (context,index){
//             final p = products[index]!;
//             return _buildProductCard(p);
//           });
//         }),
//       ),
//     );
//   }
//   Widget _buildProductCard(Products product){
//     return Card(
//       margin: EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           AspectRatio(aspectRatio: 1,
//           child: FutureBuilder<Uint8List?>(future: getmainImage(product.mainImage), builder: (context,snapshot){
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }
//             return Image.memory(snapshot.data!,fit: BoxFit.cover,);
//           }),),
//               SizedBox(height: 7,),
//               Text("name: ${product.name}"),
//               SizedBox(height: 7,),
//               Text("price: ${product.price.toString()}"),
//               SizedBox(height: 7,),
//               Text("description: ${product.description}",maxLines: 2,overflow: TextOverflow.fade,),
//         ],
//       ),
//     );
//   }
// }
