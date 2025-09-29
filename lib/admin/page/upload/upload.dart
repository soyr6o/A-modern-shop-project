
import 'dart:io';

import 'package:appwrite/models.dart' as models;
import 'package:appwrite2/admin/page/class/ProductService.dart';
import 'package:appwrite2/admin/page/class/prudact.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/product/model_product.dart';
import 'package:appwrite2/data/repositories/product/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;


class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  // final stockController = TextEditingController();

  String? selectedCategoryId;
  List<models.Row> categories = [];
  bool isPublic = true;
  File? mainImage;
  List<File> gallery = [];
  final picker = ImagePicker();

  Future<void> pickImage() async{
    final pick = await picker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        mainImage = File(pick.path);
      });
    }
  }
  Future<void> pickMulty() async{
    final pick = await picker.pickMultiImage();
    setState(() {
      gallery.addAll(pick.map((e)=>File(e.path)));
    });
  }

  final appwrite = Get.find<AppwriteService>();
  Future<void> uploadProduct() async{
    if (mainImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please take image")));
      setState(() => isPublic = true);}
    try{
      final user = await appwrite.account.get();
      final userId = user.$id;

      final mainImageId = await ProductService.uploadImage(mainImage!);
      final galleryIds = await ProductService.uploadMulty(gallery);

      final product = ProductsData(
          userId: userId,
          name: nameController.text.trim(),
          price: double.tryParse(priceController.text.trim()) ?? 100,
          mainImage: mainImageId,
          description: descController.text.trim(),
          gallery: galleryIds,
          isPublic: isPublic);

      final creatProduct = await ProductService.creatProduct(userId, product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product registered: ${creatProduct.name}")),
      );
      Navigator.pop(context,creatProduct);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "name"),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "price"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "description"),
              maxLines: 3,
            ),
            // TextField(
            //   controller: stockController,
            //   decoration: const InputDecoration(labelText: "stock"),
            //   keyboardType: TextInputType.number,
            // ),
            SwitchListTile(title: Text("Public"),value: isPublic, onChanged: (v)=> setState(()=>isPublic = v)),
            if (mainImage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(mainImage!,height: 150,),
            ),
            ElevatedButton(onPressed: pickImage, child: Text("pick image")),
            SizedBox(height: 10,),
            SizedBox(
              height: 150,
              width: 100,
              child: ListView.builder(itemCount: gallery.length,itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(gallery[index],height: 150,),
                );
              },),
            ),
            ElevatedButton(onPressed: pickMulty, child: Text("pick multi image")),
            ElevatedButton(onPressed: uploadProduct, child: Text("upload")),
          ],
        ),
      ),
    );
  }
}
