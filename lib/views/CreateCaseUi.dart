import 'package:flutter/material.dart';
import 'package:flutter_app3/widgets/MultiSelectDialog.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Create a case';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
//    void _showMultiSelect(BuildContext context) async {
//      final items = <MultiSelectDialogItem<int>>[
//        MultiSelectDialogItem(1, 'Dog'),
//        MultiSelectDialogItem(2, 'Cat'),
//        MultiSelectDialogItem(3, 'Mouse'),
//      ];}


      // Build a Form widget using the _formKey created above.
    return Form(

      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            TextFormField(
              decoration: new InputDecoration(
                labelText: "Doctor Name",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if(val.length==0) {
                  return "Doctor name cannot be empty";
                }else{
                  return null;
                }
              },
              keyboardType: TextInputType.text,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Patient Name",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              keyboardType: TextInputType.text,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
//          MultiSelect(
//              autovalidate: false,
//              titleText: 'Units',
//              validator: (value) {
//                if (value == null) {
//                  return 'Please select one or more option(s)';
//                }
//              },
//              errorText: 'Please select one or more option(s)',
//              dataSource: [
//                {
//                  "display": "1",
//                  "value": 1,
//                },
//                {
//                  "display": "2",
//                  "value": 2,
//                },
//                {
//                  "display": "3",
//                  "value": 3,
//                },
//                {
//                  "display": "4",
//                  "value": 4,
//                }
//              ],
//              textField: 'display',
//              valueField: 'value',
//              filterable: true,
//              required: true,
//              value: null,
//              onSaved: (value) {
//                print('The value is $value');
//              }
//          ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {


                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Sent')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );

  }
  }


