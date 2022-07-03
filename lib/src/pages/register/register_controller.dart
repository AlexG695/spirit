import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:integradora/src/model/response_api.dart';
import 'package:integradora/src/model/user.dart';
import 'package:integradora/src/provider/users_provider.dart';
import 'package:integradora/src/utils/my_snackbar.dart';
import 'package:integradora/src/utils/mycolors.dart';

import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController {

  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();


  UsersProvider usersProvider = new UsersProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;

  bool isEnabled = true;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);

    _progressDialog = ProgressDialog(context: context);
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmpassword = confirmpasswordController.text.trim();


    if(email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty|| password.isEmpty || confirmpassword.isEmpty){
      MySnackbar.show(context, 'Por favor llene todos los campos');
      return;
    }

    if(confirmpassword != password){
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    if(password.length < 6){
      MySnackbar.show(context, 'La contraseña debe contener al menos 6 caracteres');
      return;
    }

    if(imageFile == null) {
      MySnackbar.show(context, 'Por favor selecciona una imagen');
      return;
    }


    _progressDialog.show(max: 100, msg: 'Creando perfil...');
    isEnabled = false;

    User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password
    );

    Stream stream = await usersProvider.createWithImage(user, imageFile);
    stream.listen((res) {

      _progressDialog.close();

      //ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.message);

      if(responseApi.success){
        Future.delayed(Duration(seconds: 3), (){
          Navigator.pushReplacementNamed(context, 'login');
        });
      }
      else {
        isEnabled = true;
      }


    });


  }


  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null){
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(){
    Widget galleryButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor
      ),
      onPressed: (){
        selectImage(ImageSource.gallery);
      },
      child: Text('Galeria'),
    );

    Widget cameraButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor
      ),
      onPressed: (){
        selectImage(ImageSource.camera);
      },
      child: Text('Camara'),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen de perfil'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }

  void back() {
    Navigator.pop(context);
  }

}