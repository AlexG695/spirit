import 'package:flutter/material.dart';

class ContactController {
  BuildContext context;
  Function refresh;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }
}
