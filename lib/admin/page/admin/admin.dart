// import 'package:appwrite2/admin/page/product/product.dart';
// import 'package:appwrite2/admin/page/upload/upload.dart';
// import 'package:appwrite2/appwrite.dart';
// import 'package:flutter/material.dart';
//
// class Admin extends StatefulWidget {
//   const Admin({super.key});
//
//   @override
//   State<Admin> createState() => _AdminState();
// }
//
// class _AdminState extends State<Admin> {
//   String? userId;
//   Future<void> getuserId() async{
//     final user = await AppwriteServise.account.get();
//     setState(() {
//       userId =user.$id;
//     });
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getuserId();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Admin",style: TextStyle(fontWeight: FontWeight.bold),),
//         backgroundColor: Colors.blue,
//       ),
//       floatingActionButton: FloatingActionButton.extended(onPressed: (){
//         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Upload()));
//       }, label: Text("Upload Product",style: TextStyle(fontWeight: FontWeight.bold),)),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.all(20),
//               width: 150,
//               height: 230,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 children: [
//                      Center(
//                       child: Container(
//                         margin: EdgeInsets.only(top: 10),
//                         width: 120,
//                         height: 140,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: Colors.white,
//                           image: DecorationImage(image: AssetImage("assets/background.jpg"),fit: BoxFit.cover),
//                         ),
//                       ),
//                     ),
//                   Container(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: ElevatedButton(onPressed:userId == null ? null : (){
//                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Product(userId: userId!,)));
//                           },style: ElevatedButton.styleFrom(minimumSize: Size(90, 35),backgroundColor: Colors.grey), child: Text("product",style: TextStyle(color: Colors.black),),),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
