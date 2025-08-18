import 'package:flutter/material.dart';
import 'package:shop/future/shop/page/home/home.dart';
import 'package:shop/future/shop/page/sign/auth_supabase.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscureText = true;
  final authSupabase= AuthSupabase();
  final _confirmpassword= TextEditingController();
  void login() async{
    final email = _email.text;
    final password = _password.text;
    try{
       final response = await authSupabase.signin(email, password);
      if (response.user != null) {

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      }
    }catch(e){
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Errore: $e")));
      }  
    }
  }

  void signUp() async{
    final email = _email.text;
    final password = _password.text;
    final confirmpassword=_confirmpassword.text;
    if (password != confirmpassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password does not match")));
    }  
    try{
      await authSupabase.signUp(email, password);
    } catch(e){
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    double h= MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(child:
           Container(alignment: Alignment.center,
             decoration: BoxDecoration(
               image: DecorationImage(
                   fit: BoxFit.cover,
                   image: AssetImage("assets/back.jpg"))
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 14.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600,elevation: 5),onPressed: (){
                           showModalBottomSheet(
                               isScrollControlled: true,
                               context: context, builder: (contaxt){
                             return  SingleChildScrollView(
                               child: Padding(
                                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+200),
                                 child: Center(
                                   child: Column(
                                     children: [
                                       Container(
                                         width: 250,
                                         height: 250,
                                         decoration: BoxDecoration(
                                           image: DecorationImage(image: AssetImage("assets/signin.png")),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 35),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                                           ],
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 45,bottom: 7),
                                         child: Row(
                                           children: [
                                             Text("please sign in to continue",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                           ],
                                         ),
                                       ),
                                       SizedBox(
                                           width: 350,
                                           height: 60,
                                           child: TextField(controller: _email,style: TextStyle(),decoration: InputDecoration(prefixIcon: Icon(Icons.person),labelText: "email",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                                           )),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 5),
                                         child: SizedBox(
                                           width: 350,
                                           height: 60,
                                           child: TextField(obscureText: true,controller: _password,style: TextStyle(),decoration: InputDecoration(prefixIcon: Icon(Icons.lock),labelText: "password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                                           ),
                                           ),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green,elevation: 10),onPressed: login, child: Text("LOGIN",style: TextStyle(color: Colors.black),)),
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                             );
                           });
                         }, child: Text("LOGIN",style: TextStyle(color: Colors.black))),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,elevation: 5),onPressed: (){
                           showModalBottomSheet(
                               isScrollControlled: true,
                               context: context, builder: (contaxt){
                             return  SingleChildScrollView(
                               child: Padding(
                                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+200),
                                 child: Center(
                                   child: Column(
                                     children: [
                                       Container(
                                         width: 250,
                                         height: 250,
                                         decoration: BoxDecoration(
                                           image: DecorationImage(image: AssetImage("assets/signin.png")),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 35),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                                           ],
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 45,bottom: 7),
                                         child: Row(
                                           children: [
                                             Text("please register to login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                           ],
                                         ),
                                       ),
                                       SizedBox(
                                         width: 350,
                                         height: 60,
                                         child: TextField(controller: _email,style: TextStyle(),decoration: InputDecoration(prefixIcon: Icon(Icons.person),labelText: "email",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                                          )),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 5),
                                         child: SizedBox(
                                             width: 350,
                                             height: 60,
                                             child: TextField(obscureText: true,controller: _password,style: TextStyle(),decoration: InputDecoration(prefixIcon: Icon(Icons.lock),labelText: "password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                                             ),
                                             ),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 5),
                                         child: SizedBox(
                                           width: 350,
                                           height: 60,
                                           child: TextField(obscureText: true,controller: _confirmpassword,style: TextStyle(),decoration: InputDecoration(prefixIcon: Icon(Icons.lock),labelText: "Password repetition",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                                           ),
                                           ),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,elevation: 10),onPressed: signUp, child: Text("SIGN UP",style: TextStyle(color: Colors.black))),
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                             );
                           });
                         }, child: Text("SIGN UP",style: TextStyle(color: Colors.black))),
                       ),
                     ],
                   ),
                 )
               ],
             ),
           ),),
    );
  }
}
