import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

const URI = 'https://k2pat.ddns.net/data';
const HOST = 'k2pat.ddns.net';
const PORT = 8001;

Future<Map> fetch(params) async {
  Response response = await post(
    URI + '/vehicle/get',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(params),
  );
  Map body = jsonDecode(response.body);
  if (response.statusCode != 200) throw body['errorMsg'];
  return body;
}