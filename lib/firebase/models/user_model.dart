import 'package:storeonline/firebase/models/image_model.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  ImageModel? image;
  String? password;
  String? cPassword;


  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.password,
    this.cPassword,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    password = json['password'];
    cPassword = json['cPassword'];

  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['email'] = email;
    json['image'] = image != null ? image!.toJson() : null;
    json['password'] = password;
    json['cPassword'] = cPassword;
    return json;
  }
}
