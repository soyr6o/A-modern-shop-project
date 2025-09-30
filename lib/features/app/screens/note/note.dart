import 'package:appwrite/appwrite.dart';
import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/features/app/screens/note/model_note.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
  final appwrite = Get.find<AppwriteService>();
  final databaseId = "68c666740018d3cc0eeb";
  final tableId = "note";
  Future<void> uploadNote() async{
    final user = await appwrite.account.get();
    final userId = user.$id;
    final result = await appwrite.tables.createRow(databaseId: databaseId, tableId: tableId, rowId: ID.unique(), data: {
      "title":titleController.text,
      "description":descriptionController.text,
      "isboolean":true,
      "userId":userId,
    });
  }
  Future<List<NoteData>> getNote() async{
    final user = await appwrite.account.get();
    final userId = user.$id;
    final result = await appwrite.tables.listRows(databaseId: databaseId, tableId: tableId,queries: [Query.equal("userId", userId)]);
    return result.rows.map((row)=>NoteData.fromMap(row.data)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.brightnessOf(context)== Brightness.dark ? Colors.grey.shade900 : Colors.red.shade100,
        title: Text("N O T E  B O O K"),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        showDialog<void>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Add note'),
              content: SizedBox(
                height: MediaQuery.sizeOf(context).height/7,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        label: Text("title"),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.sizeOf(context).width,
                      child: TextFormField(
                        controller: descriptionController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          label: Text("description"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('buttonText',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),),
                  onPressed: () async {
                    MFullScreenLoader.openLoadingDialog("save note");
                    await uploadNote();
                    titleController.clear();
                    descriptionController.clear();
                    await getNote();
                    MFullScreenLoader.stopLoading();
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
      }, label: Text("Add Note",style: TextStyle(color: Colors.white),),icon: Icon(Icons.add,color: Colors.white,),backgroundColor: MColors.primary,),
      body: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: Theme.of(context).brightness == Brightness.dark ? Lottie.asset(
                MImage.background2,
                fit: BoxFit.cover,
              ) : Lottie.asset(
                MImage.background3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: FutureBuilder(future: getNote(), builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Lottie.asset(MImage.loadingAnimation5));
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("Note is empty"));
              }

              final datas = snapshot.data ?? [];
              return ListView.builder(itemCount: datas.length, itemBuilder: (context,index){
                final data = datas[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: SizedBox(
                    height: 88,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
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
                          Material(
                            color: Colors.transparent,
                            child: ListTile(
                              title: Text("${data.title}"),
                              subtitle: Text("${data.description}"),
                              tileColor: Colors.transparent,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },);
            }),
          ),
        ],
      ),
    );
  }
}
