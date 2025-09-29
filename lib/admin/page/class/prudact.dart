class Products{
  final String? id;
  final String userId;
  final String name;
  final double price;
  final String mainImage;
  final String description;
  final int? stock;
  final List<String> gallery;
  final String? categoryId;
  final bool isPublic;

  Products({this.id, required this.userId, required this.name, required this.price, required this.mainImage, required this.description,this.stock, required this.gallery,this.categoryId, required this.isPublic});

  factory Products.fromMap(Map<String,dynamic> map , {String? $id}){
    return Products(
        id: $id,
        userId: map["userId"] ?? "",
        name: map["name"] ?? "",
        price:double.tryParse(map["price"].toString()) ?? 100 ,
        mainImage: map["mainImage"],
        description: map["description"],
        gallery: List<String>.from(map["gallery"]) ?? [],
        isPublic: map["isPublic"]==true,
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "price":price,
      "mainImage":mainImage,
      "description":description,
      "stock":stock,
      "gallery":gallery,
      "categoryId":categoryId,
      "isPublic":isPublic,
    };
  }
}