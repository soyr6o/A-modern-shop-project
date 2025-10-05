class NoteData{
  String? $id;
  String userId;
  String title;
  String description;
  bool isboolean;
  NoteData({this.$id,required this.userId,required this.title,required this.description,required this.isboolean});
  factory NoteData.fromMap(Map<String,dynamic> map,{String? $id}){
    final dynamic isBoolRaw = map["isboolean"];
    final bool isBoolParsed = isBoolRaw is bool
        ? isBoolRaw
        : (isBoolRaw is String
            ? (isBoolRaw.toLowerCase() == "true")
            : false);
    return NoteData(
      $id: $id,
      userId: map["userId"] ?? "",
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      isboolean: isBoolParsed,
    );
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