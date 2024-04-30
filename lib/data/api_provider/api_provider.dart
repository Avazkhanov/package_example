import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_example/data/network_response.dart';

class ApiProvider {
  static Future<NetworkResponse> getCurrencies() async {
    try {
      final response =
          await Dio().get('https://nbu.uz/en/exchange-rates/json/');
      return NetworkResponse(data: response.data);
    } catch (e) {
      return NetworkResponse(errorMessage: e.toString());
    }
  }
}
