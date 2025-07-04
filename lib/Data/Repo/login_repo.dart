import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:time_dignitor_task/Data/Model/login_request.dart';
import 'package:time_dignitor_task/Data/Model/login_response.dart';
import 'package:time_dignitor_task/Data/api_service.dart';

class LoginRepo{
  ApiService api = ApiService();

  Future<LoginResponse> fetchLogin(LoginRequest request) async{

    try{
      Response response = await api.sendRequest.post("auth/login", data: request);
      debugPrint("Response => $response");

      final loginData = LoginResponse.fromJson(response.data);

      return loginData;

    }
    catch (ex){
      rethrow;
    }
  }
}