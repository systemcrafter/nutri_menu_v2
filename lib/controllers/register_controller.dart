import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> register(String name, String email, String password) async {
  const String baseUrl =
      'http://10.0.2.2:8000/api/register'; // emulador Android
  // const String baseUrl = 'http://localhost:8000/api/register';  // emulador Web

  var client = http.Client();
  var url = Uri.parse(baseUrl);
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'cache-control': 'no-cache'
  };

  var body = json.encode({
    'name': name,
    'email': email,
    'password': password,
  });

  var response = await client.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    debugPrint(response.body);
    return true;
  } else {
    debugPrint('Error en la petición');
    return false;
  }
}
