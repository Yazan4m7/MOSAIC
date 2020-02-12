import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class WriteToFile {
  static var directory;
  static var file;

  static void prepareLogFile() async {
    print('preparing');
    directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/my_file.txt');
    print(file == null);
  }

  static void write(String text) async {
    if  (file == null) prepareLogFile();
    await file.writeAsString('['+ DateTime.now().toString()+'] '+ text + "\n",mode: FileMode.append);
  }

  static openLogs() async{
    OpenFile.open(file.path);
   }
  static clearLogs() async{
    file.writeAsString("");
  }
}