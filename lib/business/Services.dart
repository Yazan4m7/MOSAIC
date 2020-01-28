import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../models/Task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/main_ui.dart';

class Services {
  static const ROOT = 'http://10.0.2.2/services_actions.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const _LOGIN = 'LOGIN';

  // Method to create the table Employees.
//  static Future<String> createTable() async {
//    try {
//      // add the parameters to pass to the request.
//      var map = Map<String, dynamic>();
//      map['action'] = _CREATE_TABLE_ACTION;
//      final response = await http.post(ROOT, body: map);
//      print('Create Table Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }

  /*static List myGetEmployees() {
    var map = Map<String, dynamic>();
    map['action'] = _GET_ALL_ACTION;
    String data;
    http.post(ROOT, body: map)
        .then((response) => data = response.body)
        .catchError((error) => print(error));
    print("my get employees : $data");
    return parseResponse(data);
  }*/

  static Future<List<Task>> getEmployees() async {

      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('getEmployees Tasks: ${response.body}');

        List<Task> list = parseResponse(response.body);
        print(list);
        return list;
  }

  static List<Task> parseResponse(String responseBody) {

    var parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    parsed = parsed.map<Task>((json) => Task.fromJson(json)).toList();
    return parsed;
  }
  static AssignTask(int caseID, String userName, String stage) async{
    var map = Map<String, dynamic>();
    map['action'] = "UPDATE_task_to_active";



  }
  static Future<bool> logIn(String username,String password,BuildContext context) async{

    var map = Map<String, dynamic>();
    map['action'] = _LOGIN;
    map['username'] = username;
    map['password'] = password;
    final response =await http.post(ROOT, body: map);
    print('Login Response: ${response.body}');
    if (response.body.isNotEmpty){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user_name",jsonDecode(response.body)[0]['username']);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => main_ui()));
      return true;
    }
    Alert(context: context, title: "Oops", desc: "Invalid username/password").show();
    return false;
  }

//  // Method to add employee to the database...
//  static Future<String> addEmployee(String firstName, String lastName) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _ADD_EMP_ACTION;
//      map['first_name'] = firstName;
//      map['last_name'] = lastName;
//      final response = await http.post(ROOT, body: map);
//      print('addEmployee Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
//  // Method to update an Employee in Database...
//  static Future<String> updateEmployee(
//      String empId, String firstName, String lastName) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _UPDATE_EMP_ACTION;
//      map['emp_id'] = empId;
//      map['first_name'] = firstName;
//      map['last_name'] = lastName;
//      final response = await http.post(ROOT, body: map);
//      print('updateEmployee Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
//  // Method to Delete an Employee from Database...
//  static Future<String> deleteEmployee(String empId) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _DELETE_EMP_ACTION;
//      map['emp_id'] = empId;
//      final response = await http.post(ROOT, body: map);
//      print('deleteEmployee Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error"; // returning just an "error" string to keep this simple...
//    }
//  }
}