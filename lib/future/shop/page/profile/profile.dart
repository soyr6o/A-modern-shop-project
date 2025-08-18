import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/future/shop/page/sign/auth_supabase.dart';
import 'package:shop/future/shop/page/sign/sign.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final authSupabase =AuthSupabase();

  void logout() async{
    await authSupabase.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Sign()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(
      child: ElevatedButton(onPressed: logout, child: const Text("loge out")),
    )),);
  }
}
