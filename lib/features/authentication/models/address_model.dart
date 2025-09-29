class AddressUser{
  String name;
  String phoneNumber;
  String street;
  String postCode;
  String city;
  String state;
  String country;
  String? userId;
  AddressUser({this.userId,required this.name,required this.phoneNumber,required this.street,required this.postCode,required this.city,required this.state,required this.country});

  factory AddressUser.fromMap(Map<String,dynamic> map){
    return AddressUser(userId: map["userId"],name: map["name"], phoneNumber: map["phoneNumber"], street: map["street"], postCode: map["postCode"], city: map["city"], state: map["state"], country: map["country"]);
  }

  Map<String,dynamic> toMap(){
    return{
      "userId":userId,
      "name":name,
      "phoneNumber":phoneNumber,
      "street":street,
      "postCode":postCode,
      "city":city,
      "state":state,
      "country":country,
    };
  }
}