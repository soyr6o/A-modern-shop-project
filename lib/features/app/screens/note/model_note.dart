class NoteData{
  String userId;
  String title;
  String description;
  bool isboolean;
  NoteData({required this.userId,required this.title,required this.description,required this.isboolean});
  factory NoteData.fromMap(Map<String,dynamic> map){
    return NoteData(userId: map["userId"],title: map["title"]?? "", description: map["description"] ?? "", isboolean: map["isboolean"] ?? "");
  }
  Map<String,dynamic> toMap(){
    return {
      "userId":userId,
      "title":title,
      "description":description,
      "isboolean":isboolean
    };
  }

}