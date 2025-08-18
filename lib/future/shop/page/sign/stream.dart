import 'package:flutter/material.dart';
import 'package:shop/future/shop/page/home/home.dart';
import 'package:shop/future/shop/page/sign/sign.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StreamPage extends StatelessWidget {
  const StreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Supabase.instance.client.auth.onAuthStateChange, builder: (context,snapshot){
     if (snapshot.connectionState == ConnectionState.waiting) {
       return Scaffold(body: Center(child: CircularProgressIndicator(),),);
     }

     final data = snapshot.data;
     final session = data?.session;
     if (session != null) {
        return Home();
     }else{
       return Sign();
     }
    });
  }
}
