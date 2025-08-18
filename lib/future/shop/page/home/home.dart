import 'package:flutter/material.dart';
import 'package:shop/future/shop/page/home/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Column(
      children: [
        const Center(child: Text("data")),
        ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Profile()));
        }, child: const Text("profile"))
      ],
    )),);
  }
}
