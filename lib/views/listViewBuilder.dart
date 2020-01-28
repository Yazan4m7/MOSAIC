import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/models/Task.dart';
import 'package:flutter/material.dart';
import '../business/Services.dart';

void main() => runApp(listView());

class listView extends StatelessWidget {
  List<Task> _employees = [];

  Card cardForEachCase(Task task) {
    return new Card(
      child: new Container(
        padding: EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            new CircleAvatar(
              child: new Text(task.patient_name),
            ),
            new Padding(padding: EdgeInsets.only(right: 10.0)),
            new Text(
              task.patient_name,
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getEmployees();
    return MaterialApp(
        home: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: _employees.length,
            itemBuilder: (_, int index) {

                return cardForEachCase(this._employees[index]);}
          ),
        ),
      ],
    ));
  }
  _getEmployees() async {
    await Services.getEmployees().then((tasks) {
        _employees = tasks;
        print(tasks.length);
    });
  }
}
