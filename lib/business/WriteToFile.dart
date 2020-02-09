import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class WriteToFile extends LogOutput {
  static var directory;
  static var file;

  static void prepareLogFile() async {
    print('preparing');
    directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/my_file.txt');
  }

  @override
  void output(OutputEvent event) {
    write(event.lines.toString());
  }

  static void write(String text) async {
    if (file== null) prepareLogFile();
    await file.writeAsString(text);
  }


  static openLogs() async{
    final Directory directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/logs1.txt');
    //String contents = await file.readAsString();
    //LoginUIState.showDefaultSnackbar(context, 'contents: $contents');
    print(file.path);
    OpenFile.open(file.path);


   }

}
