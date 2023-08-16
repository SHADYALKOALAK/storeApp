import 'package:flutter/cupertino.dart';
import 'package:storeonline/firebase/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  set user(UserModel? _) => [_user = _, notifyListeners()];
}
