import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/future/shop/page/botton/botton.dart';
import 'package:shop/future/shop/page/favorit/favorit.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          title: Text("ZRTX",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
          backgroundColor: Colors.grey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom:Radius.circular(15))
          ),
          actions: [
            IconButton(onPressed:  (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Favorit()));
            }, icon: Icon(Icons.favorite,color: Colors.white,)),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag,size: 32,color: Colors.white,)),
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.white
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 145),
                    child: ListTile(
                      title: CircleAvatar(
                        radius: 40,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 270),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                        ),
                        child: ListView(
                          children: [
                            ListTile(
                              leading: Icon(Icons.home),
                              title: Text("H O M E",style: TextStyle(fontWeight: FontWeight.bold),),
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottonPage()));
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.shopping_cart),
                              title: Text("shopping cart",style: TextStyle(fontWeight: FontWeight.bold),),
                              onTap: (){},
                            ),
                            ListTile(
                              leading: Icon(IconlyLight.category),
                              title: Text("Categories",style: TextStyle(fontWeight: FontWeight.bold),),
                              onTap: (){},
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 4, 10),
                        child: InkWell(
                          onTap:(){},
                          child: CircleAvatar(
                            radius: 40,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap:(){},
                          child: CircleAvatar(
                            radius: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 250,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex:4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                        )),
                                    Expanded(
                                        flex:2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("name:",style: TextStyle(fontWeight: FontWeight.bold),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Price:",style: TextStyle(fontWeight: FontWeight.bold),),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 250,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex:4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                        )),
                                    Expanded(
                                        flex:2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("name:",style: TextStyle(fontWeight: FontWeight.bold),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Price:",style: TextStyle(fontWeight: FontWeight.bold),),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),),
    );
  }
}
