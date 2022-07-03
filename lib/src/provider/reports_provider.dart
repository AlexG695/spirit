import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integradora/src/api/environment.dart';
import 'package:integradora/src/model/report.dart';
import 'package:integradora/src/model/user.dart';
import 'package:integradora/src/utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportProvider {
  String _url = Environment.API_RESCUE;
  String _api = '/api/report';
  User sessionUser;

  BuildContext context;

  Future init(BuildContext context, {User sessionUser}) {
    this.context = context;
  }

  Future<List<Report>> getAllReports() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAllReports');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        //NO AUTORIZADO
        Fluttertoast.showToast(msg: 'Tu sesión expiro');
        new SharedPref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body);
      Report report = Report.fromJsonList(data);
      return report.toList;
    } catch (e) {
      print('Error $e');
      return null;
    }
  }
}
