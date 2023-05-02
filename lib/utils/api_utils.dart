import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ticketing_system/utils/token_util.dart';

class ApiUtils {
  static Future<dynamic> fetchData(BuildContext context, String url) async {
    final token = await TokenUtil().getToken();

    final response = await http.get(
      Uri.parse('http://localhost:5000/$url/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    final statusCode = response.statusCode;

    if (statusCode == 401) {
      TokenUtil().deleteToken();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    }

    if (statusCode == 500) {
      throw Exception('Failed to fetch protected data');
    }

    return json.decode(response.body);
  }

  static Future<dynamic> submitData(
      BuildContext context, String url, formData) async {
    final token = await TokenUtil().getToken();

    final response = await http.post(
      Uri.parse('http://localhost:5000/$url/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(formData),
    );

    final statusCode = response.statusCode;

    if (statusCode == 401) {
      TokenUtil().deleteToken();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    }

    if (statusCode == 500) {
      throw Exception('Failed to fetch data');
    }

    return response;
  }
}
