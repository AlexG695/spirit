import 'package:flutter/cupertino.dart';
import 'package:integradora/src/api/environment.dart';

class ContactProvider {
  String _url = Environment.API_RESCUE;
  String _api = '/api/contact';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }
}
