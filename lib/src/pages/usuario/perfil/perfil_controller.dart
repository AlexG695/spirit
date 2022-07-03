import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integradora/src/model/response_api.dart';
import 'package:integradora/src/model/user.dart';
import 'package:integradora/src/provider/users_provider.dart';
import 'package:integradora/src/utils/my_snackbar.dart';
import 'package:integradora/src/utils/mycolors.dart';
import 'package:integradora/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class PerfilController {
  BuildContext context;
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  PickedFile pickedFile;
  io.File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;

  bool isEnabled = true;
  User user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    usersProvider.init(context, sessionUser: user);
    nameController.text = user.name;
    lastnameController.text = user.lastname;
    phoneController.text = user.phone;
    refresh();
  }

  void update() async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();

    if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Por favor llene todos los campos');
      return;
    }

    _progressDialog.show(max: 100, msg: 'Actualizando tu información...');
    isEnabled = false;

    User myUser = new User(
        id: user.id,
        name: name,
        lastname: lastname,
        phone: phone,
        image: user.image);

    Stream stream = await usersProvider.update(myUser, imageFile);
    stream.listen((res) async {
      _progressDialog.close();

      //ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message);

      if (responseApi.success) {
        user = await usersProvider
            .getById(myUser.id); //OBTENIENDO EL USUARIO DE LA BD
        print('Usuario obetnido: ${user.toJson()}');
        _sharedPref.save('user', user.toJson());
        Navigator.pushNamedAndRemoveUntil(
            context, 'usuario/inicio', (route) => false);
      } else {
        isEnabled = true;
      }
    });
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = io.File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
      style: ElevatedButton.styleFrom(primary: MyColors.primaryColor),
      onPressed: () {
        selectImage(ImageSource.gallery);
      },
      child: Text('Galeria'),
    );

    Widget cameraButton = ElevatedButton(
      style: ElevatedButton.styleFrom(primary: MyColors.primaryColor),
      onPressed: () {
        selectImage(ImageSource.camera);
      },
      child: Text(
        'Camara',
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void back() {
    Navigator.pop(context);
  }
}
