class WishListModel{
  String productid ;
  String userId;
  WishListModel({required this.productid , required this.userId});
  factory WishListModel.fromMap(Map<String, dynamic> map) {
    return WishListModel(
      productid : map['productid '],
      userId: map['userId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'productid ': productid,
      'userId': userId,
    };
  }
}