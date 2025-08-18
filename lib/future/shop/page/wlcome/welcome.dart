import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop/future/shop/page/botton/botton.dart';
import 'package:shop/future/shop/page/sign/stream.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(milliseconds: 400), (){
      setState(() {
        op1=1;
      });
    });
    super.initState();
  }
  double op1=0;
  double op2=0;
  double op3=0;
  double t1=10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: AnimatedOpacity(
          opacity: op1,
          duration: Duration(milliseconds: 400),
          onEnd: (){
            setState(() {
              t1=0;
            });
          },
          child: Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.cover,image: AssetImage("assets/welcome.jpg"),),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent,Colors.black]),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedSlide(
                    offset:Offset(0, t1),
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeOutBack,
                    child: Text("SHOP ZTRX",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white70),)),
                    AnimatedSlide(
                    offset: Offset(0, t1),
                    duration: Duration(milliseconds: 600),
                    onEnd: (){
                      setState(() {
                        op2=1;
                        op3=1;
                      });
                    },
                    curve: Curves.ease,
                    child: Text("A store for everyone",style: TextStyle(fontSize: 20,color: Colors.white60),)),
                    Center(
                      child: Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: op3,
                            duration: Duration(milliseconds: 1200),
                            curve: Curves.decelerate,
                            onEnd: (){
                              setState(() {
                                if (op3==0) {
                                  op3=1;
                                }else{
                                  op3=0;
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 90,top: 30),
                              width: 160,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.grey.shade400,
                                boxShadow: [BoxShadow(
                                  color: Colors.grey.shade600,
                                  blurRadius: 30,
                                  spreadRadius: 0,
                                )]
                              ),
                              child: Center(child: Text("WELCOME",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: op2,
                            duration: Duration(milliseconds: 800),
                            curve: Curves.decelerate,
                            onEnd: (){},
                            child: InkWell(
                              onTap: (){},
                              child: Container(
                                margin: EdgeInsets.only(bottom: 90,top: 30),
                                width: 160,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.grey.shade400,
                                ),
                                child: Center(child: InkWell(
                                    onTap: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottonPage()));
                                    },
                                    child: Text("WELCOME",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),),
    );
  }
}
