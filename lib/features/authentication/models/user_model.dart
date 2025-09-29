import 'package:appwrite/models.dart';
import 'package:appwrite/models.dart' as models;

class UserModel{
  final String? id;
  final String? userId;
  String firstname;
  String lastname;
  final String username;
  final String email;
  String phonenumber;
  String picture;

  UserModel({this.id,
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.phonenumber,
    required this.picture,
  });

  static UserModel empty ()=> UserModel(id: "",userId: "", firstname:"", lastname: "", username: "", email: "", phonenumber: "", picture:"");

  factory UserModel.fromDocument(models.Document document) {
    final data = document.data;

    if (data != null && data.isNotEmpty) {
      return UserModel(
        id: document.$id,
        userId: data['userId'] ?? '',
        firstname: data['firstname'] ?? '',
        lastname: data['lastname'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phonenumber: data['phonenumber'] ?? '',
        picture: data['picture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }


  Map<String,dynamic> toMap(){
    return{
      'userId':userId,
      'firstname':firstname,
      'lastname':lastname,
      'username':username,
      'email':email,
      'phonenumber':phonenumber,
      'picture':picture,
    };
  }
}