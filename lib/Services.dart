import 'dart:convert';
import 'package:http/http.dart'
as http;
import 'Task.dart';

class Services {
  static const ROOT = 'http://10.0.2.2/server_services.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

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
//        print(list);
        return list;
  }

  static List<Task> parseResponse(String responseBody) {

    var parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    parsed = parsed.map<Task>((json) => Task.fromJson(json)).toList();
    return parsed;
  }

  static String logIn(String username, String password){
    var map = Map<String, dynamic>();
    map['action']="LOGIN";
    map['username'] = username;
    map['password'] = password;
    final response = http.post(ROOT, body: map);
    //if (response.statusCode )

  }

  static AssignTask(int caseID, String userName, String stage) async{
    var map = Map<String, dynamic>();
    map['action'] = "ASSIGN_TASK";


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