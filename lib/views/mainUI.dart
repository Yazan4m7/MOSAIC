import 'package:flutter/material.dart';
import '../models/Employee.dart';
import '../business/Services.dart';
import '../models/Task.dart';
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

  // controller for the First Name TextField we are going to create.
  TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _lastNameController;
  Employee _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
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

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getEmployees() async {
    _showProgress('Loading Employees...');
    await Services.getTasks().then((tasks) {
      setState(() {
        _employees = tasks;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${tasks.length}");
    });
  }

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
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
            // Lets add one more column to show a delete button
            CustomDataColumn(
              label: Text('Assign to me'),
            )
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
                          task.stage == "waiting"?
                          DialogButton(
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
                                    Services.updateToDone(task.id,task.current_status);
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
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  CustomDataCell(IconButton(
                    icon: Icon(Icons.slideshow),
                    onPressed: () {
                      //_deleteEmployee(employee);
                    },
                  ))
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
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
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
