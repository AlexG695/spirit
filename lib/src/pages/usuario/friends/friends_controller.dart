import 'package:flutter/material.dart';
import 'package:integradora/src/model/user.dart';
import 'package:integradora/src/provider/users_provider.dart';
import 'package:integradora/src/utils/shared_pref.dart';

class FriendsController {
  BuildContext context;
  Function refresh;
  User user;
  UsersProvider usersProvider;
  SharedPref _sharedPref;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;

    
  }

  
}
