import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../models/Case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/CasesUi.dart';
import 'WriteToFile.dart';

class Services {
  static const ROOT = 'http://manshore.com/services_actions.php';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _LOGIN = 'LOGIN';
  static List<String> lines=List();
  OutputEvent oe=OutputEvent(Level.debug, lines);
  static LogOutput lo = WriteToFile();
  static Logger logger = Logger(output: lo);

  static Future<List<Task>> getCases() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String permissions = "(" + prefs.get('permissions_ids') +")";
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['query'] = "SELECT * from tasks WHERE current_status in $permissions ORDER BY id DESC";
      final response = await http.post(ROOT, body: map);
      print('get all response body: ${response.body}');

        List<Task> list = parseResponse(response.body);

        return list;
  }

  static List<Task> parseResponse(String responseBody) {

    var parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    parsed = parsed.map<Task>((json) => Task.fromJson(json)).toList();
    return parsed;
  }

  static updateToActive(int caseID, String currentStatus, String stage) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phaseBeingDone;
    switch(int.parse(currentStatus)){
      case 0: phaseBeingDone="design";break;
      case 1: phaseBeingDone="milled";break;
      case 2: phaseBeingDone="sintered";break;
      case 3: phaseBeingDone="finished";break;
      case 4: phaseBeingDone="approved";break;
      case 5: phaseBeingDone="delivered";break;

    }

    String query = "UPDATE tasks SET ${phaseBeingDone}_by = '${prefs.get('name')}' , stage='active' WHERE id = $caseID";
    print("query is : $query");


    var map = Map<String, dynamic>();
    map['query'] = query;
    map ['action'] = "UPDATE_task_to_active";
    final response = await http.post(ROOT, body: map);
    print('Assign task reponse body: ${response.body}');

  }

  static updateToDone(int caseID, String currentStatus) async{

    String query = "UPDATE tasks SET current_status ='${int.parse(currentStatus)+1}' , stage='waiting' WHERE id = $caseID";
    print("query is : $query");

    var map = Map<String, dynamic>();
    map['query'] = query;
    map ['action'] = "UPDATE_task_to_done";
    final response = await http.post(ROOT, body: map);
    print('Assign task to done reponse body: ${response.body}');

  }

  static Future<bool> logIn(String username,String password,BuildContext context) async{

    var map = Map<String, dynamic>();
    map['action'] = _LOGIN;
    map['username'] = username;
    map['password'] = password;
    final response =await http.post(ROOT, body: map);
    logger.i(map.toString());
    if (response.body.isNotEmpty){
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("user_name",jsonDecode(response.body)[0]['username']);
      prefs.setString("name",jsonDecode(response.body)[0]['name']);
      prefs.setString("permissions_ids",jsonDecode(response.body)[0]['permissions_ids']);
      logger.i('Prefs set successfuly for ${prefs.get('username')}');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => main_ui()));
      return true;
    }
    else {
      logger.i('Login response body is empty');
      Alert(context: context, title: "Oops", desc: "Invalid username/password")
          .show();
      return false;
    }
  }

}