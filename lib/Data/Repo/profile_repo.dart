
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_dignitor_task/Data/Model/profile_response.dart';
import 'package:time_dignitor_task/Data/api_service.dart';

class ProfileRepo{
  ApiService api = ApiService();

  Future<ProfileResponse> fetchProfile() async{

    try{
      Response response = await api.sendRequest.get("auth/me", );
      debugPrint("Response => $response");

      final profileData = ProfileResponse.fromJson(response.data);

      return profileData;

    }
    catch (ex){
      rethrow;
    }
  }

}

