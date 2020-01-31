import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class WriteToFile extends LogOutput{
  @override
  void output(OutputEvent event)  {
    _write(event.lines.toString());
  }
  _write(String text) async {
    print('writing $text');
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}logs.txt');
    print(file.path);
    await file.writeAsString(text);

  }
  static openLogs() async{
    final Directory directory = await getApplicationDocumentsDirectory();
    OpenFile.open('${directory.path}logs.txt');

  }
  }
