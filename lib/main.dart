import 'package:flutter/material.dart';
import 'package:shop/future/shop/page/sign/sign.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'future/shop/page/wlcome/welcome.dart';
 String url="https://kqvedyhkqkitxdruluaj.supabase.co";
 String anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxdmVkeWhrcWtpdHhkcnVsdWFqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU0MzIxOTYsImV4cCI6MjA3MTAwODE5Nn0.8Hq9eN0v1YbestibBid1lWv9002_4QpWRCog7ja7npU";
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url, anonKey: anonKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}
