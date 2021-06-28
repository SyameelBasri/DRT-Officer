import 'package:realtime_ocr/services/database.dart';

Map params = {"ve_reg_num": "PPP3"};

void main() async{
  //print(params);
  var data = await fetch(params);
  print(data);
}