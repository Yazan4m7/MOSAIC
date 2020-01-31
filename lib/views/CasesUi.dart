import 'package:flutter/material.dart';
import 'package:flutter_app3/business/WriteToFile.dart';
import '../models/Employee.dart';
import '../business/Services.dart';
import '../models/Case.dart';
import '../CustomDataTable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new main_ui(),
    );
  }
}

class main_ui extends StatefulWidget {
  //
  main_ui() : super();

  final String title = 'MOSAIC - Cases list';

  @override
  main_uiState createState() => main_uiState();
}

class main_uiState extends State<main_ui> {
  List<Task> _employees;



  @override
  void initState() {
    super.initState();
    _employees = [];
    _getEmployees();

    var alertStyle = AlertStyle(
      overlayColor: Colors.blue[400],
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Color.fromRGBO(91, 55, 185, 1.0),
      ),
    );
  }


  _getEmployees() async {

    await Services.getCases().then((tasks) {
      setState(() {
        _employees = tasks;
      });

      print("Length ${tasks.length}");
    });
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: CustomDataTable(
          columns: [
            CustomDataColumn(
              label: Text('Patient Name'),
            ),
            CustomDataColumn(
              label: Text('Doctor name'),
            ),
            CustomDataColumn(
              label: Text('Phase'),
            ),
          ],
          rows: _employees
              .map(
                (task) => CustomDataRow(cells: [
                  CustomDataCell(Text(task.patient_name),
                      // Add tap in the row and populate the
                      // textfields with the corresponding values to update
                      onTap: () {
                    Alert(
                        context: context,
                        title: "patient : ${task.patient_name}",
                        content: Column(
                          children: <Widget>[],
                        ),
                        buttons: [
                          task.stage == "waiting"
                              ? DialogButton(
                                  onPressed: () {
                                    Services.updateToActive(task.id,
                                        task.current_status, task.stage);
                                  },
                                  child: Text(
                                    "Assign task",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              : DialogButton(
                                  onPressed: () {
                                    Services.updateToDone(
                                        task.id, task.current_status);
                                  },
                                  child: Text(
                                    "Mark as done",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                          DialogButton(
                            onPressed: () {
                              print("view task");
                            },
                            child: Text(
                              "View task",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ]).show();
                  }),
                  CustomDataCell(Row(
                    children: <Widget>[
                      Text(
                        task.doctor_id.toString(),
                      ),
                    ],
                  )),
                  CustomDataCell(
                    Text(
                      task.stage,
                    ),
                    onTap: () {
                      // _showValues(task);
                      // Set the Selected employee to Update
                      // _selectedEmployee = task;

                    },
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MOSAIC'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          ),IconButton(
            icon: Icon(Icons.folder_open),
            onPressed: () {
              WriteToFile.openLogs();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SizedBox(
                height: 20,
              ),
            ),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
    );
  }
}
