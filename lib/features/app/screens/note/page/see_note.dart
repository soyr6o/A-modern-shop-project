import 'dart:ui';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/features/app/screens/note/model_note.dart';
import 'package:appwrite2/features/app/screens/note/note.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:appwrite2/utils/constants/keys.dart';

class SeeNote extends StatefulWidget {
  String rowId;
  SeeNote({super.key,required this.rowId});

  @override
  State<SeeNote> createState() => _SeeNoteState();
}

class _SeeNoteState extends State<SeeNote> {
  final databaseId = MKeys.databaseIdNotes;
  final tableId = MKeys.tableNotes;

  final appwrite = Get.find<AppwriteService>();
  Future<NoteData> getNote() async{
    final result = await appwrite.tables.getRow(databaseId: databaseId, tableId: tableId, rowId: widget.rowId);
    return NoteData.fromMap(result.data);
  }
  Future<void> deleteRow() async{
    await appwrite.tables.deleteRow(databaseId: databaseId, tableId: tableId, rowId: widget.rowId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(backgroundColor: MColors.primary,onPressed: () async {
        MFullScreenLoader.openLoadingDialog("Delete Note");
        await deleteRow();
        setState(() {});
        MFullScreenLoader.stopLoading();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Note()));
      }, label: Text("Delete",style: TextStyle(color: Colors.white),)),
      appBar: AppBar(
        backgroundColor: Theme.brightnessOf(context)== Brightness.dark ? Colors.grey.shade900 : Colors.red.shade100,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: RepaintBoundary(
                child: Theme.of(context).brightness == Brightness.dark ? Lottie.asset(
                  MImage.background1,
                  fit: BoxFit.cover,
                ) : Lottie.asset(
                  MImage.background4,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FutureBuilder(future: getNote(), builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Lottie.asset(MImage.loadingAnimation5));
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              final note = snapshot.data;
              if (note == null) {
                return Center(child: Text("Note is empty"),);
              }
              return Padding(padding: EdgeInsets.all(1),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    width: double.infinity,
                      height: MediaQuery.sizeOf(context).height/9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0x33FFFFFF),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,top: 35),
                        child: Text(note.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      )),
                  Container(
                      margin: EdgeInsets.all(8),
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height/1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0x33FFFFFF),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,top: 35),
                        child: Text(note.description,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      )),
                ],
              ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
