import 'package:flutter/cupertino.dart';
import 'package:integradora/src/model/response_api.dart';
import 'package:integradora/src/model/user.dart';
import 'package:integradora/src/provider/push_notification_provider.dart';
import 'package:integradora/src/provider/users_provider.dart';
import 'package:integradora/src/utils/my_snackbar.dart';
import 'package:integradora/src/utils/shared_pref.dart';

class LoginController {
  BuildContext context;
  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();

  UsersProvider usersProvider =  UsersProvider();
  SharedPref _sharedPref =  SharedPref();

  PushNotificationsProvider pushNotificationsProvider =
      new PushNotificationsProvider();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    if (user.sessionToken != null) {
      pushNotificationsProvider.saveToken(user, context);
      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles[0].route, (route) => false);
      }
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);

    if (responseApi == true) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      pushNotificationsProvider.saveToken(user, context);

      print('Usuario logeado: ${user.toJson()}');

      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles[0].route, (route) => false);
      }
    } else {
      MySnackbar.show(context, responseApi.message);
    }
  }
}
