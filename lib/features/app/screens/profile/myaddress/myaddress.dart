import 'package:appwrite2/data/repositories/user/fetch_address.dart';
import 'package:appwrite2/data/repositories/user/fetch_user.dart';
import 'package:appwrite2/features/app/screens/profile/myaddress/addaddress/addaddress.dart';
import 'package:appwrite2/features/app/screens/profile/profile.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'eiteaddress/editaddress.dart';

class MyAddress extends StatelessWidget {
  const MyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final getAddress = FetchAddress();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddAddres()));
      }, label: Icon(Iconsax.add,color: Colors.white,),backgroundColor: MColors.primary,),
      appBar: AppBar(
        title: Text("Addresses"),
      ),
      body: SafeArea(child: FutureBuilder<List<Map<String, dynamic>>>(future: getAddress.getUserAddress(), builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.none) {
          return Center(child: Text("please check your Internet"),);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: Lottie.asset(MImage.loadingAnimation5),),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text("Error: ${snapshot.error}"),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Refresh the page
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyAddress())
                    );
                  },
                  child: Text("Retry"),
                ),
              ],
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_off, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text("No addresses found"),
                SizedBox(height: 16),
                Text("Add your first address by tapping the + button"),
              ],
            ),
          );
        }
        final address = snapshot.data!;
        return ListView.builder(itemCount: address.length,itemBuilder: (context,index){
          final addressData = address[index];
          return InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditAddress(rowId: addressData["\$id"],)));
            },
            child: Card(
              elevation: 4, // سایه
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // گوشه گرد
              ),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade400 : Colors.white, // رنگ پس‌زمینه
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(Icons.person,size:24,color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,),SizedBox(width: 5,),
                        Expanded(
                          child: Text(
                            "Name: ${addressData["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "street: ${addressData["street"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "city: ${addressData["city"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              "state: ${addressData["state"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Country: ${addressData["country"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 10),
                          child: Text(
                              "Post Code: ${addressData["postCode"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 10),
                          child: Expanded(
                            child: Text(
                              "Phone: ${addressData["phoneNumber"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      }),),
    );
  }
}
