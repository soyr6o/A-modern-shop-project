class SaveModel {
  final String userId;
  final String productId;
  final int quantity;
  final double priceAtAdd;
  final String productName;
  final String mainImageId;

  SaveModel({
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.priceAtAdd,
    required this.productName,
    required this.mainImageId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      'priceAtAdd': priceAtAdd,
      'productName': productName,
      'mainImageId': mainImageId,
    };
  }

  factory SaveModel.fromMap(Map<String, dynamic> map) {
    return SaveModel(
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0,
      priceAtAdd: (map['priceAtAdd'] ?? 0).toDouble(),
      productName: map['productName'] ?? '',
      mainImageId: map["mainImageId"] ?? '',
    );
  }
}
