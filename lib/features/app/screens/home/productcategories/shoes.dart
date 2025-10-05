import 'dart:typed_data';

import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/features/app/screens/home/productcategories/widget/getcategori.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite2/utils/constants/keys.dart';
import 'package:get/get_core/src/get_main.dart';

class Shoes extends StatefulWidget {
  const Shoes({super.key});

  @override
  State<Shoes> createState() => _ShoesState();
}

class _ShoesState extends State<Shoes> {
  late Future<List<Map<String, dynamic>>> _productState;
  final getCategories = GetCategories();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productState = getCategories.getSport();
  }
  Future<Uint8List?> getImage(String fileId) async {
    final appwrite = Get.find<AppwriteService>();
    final bytes = await appwrite.storage.getFileView(
      bucketId: MKeys.bucketProducts,
      fileId: fileId,
    );
    return bytes;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoes",style: TextStyle(fontSize: 20),),
      ),
      body: SafeArea(child: Column(),),
    );
  }
}
