
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_dignitor_task/Data/Model/login_request.dart';
import 'package:time_dignitor_task/Data/Model/login_response.dart';
import 'package:time_dignitor_task/Data/Repo/login_repo.dart';
import 'package:time_dignitor_task/Logic/Login/login_state.dart';
import 'package:time_dignitor_task/Utils/NetworkErrorHandler.dart';
import 'package:time_dignitor_task/Utils/network_info.dart';
import 'package:time_dignitor_task/Utils/sharedPeferences.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginRepo repo = LoginRepo();
  NetworkInfo networkInfo = NetworkInfo(Connectivity());
  SharedPre sp = SharedPre();
  LoginCubit() : super(LoginLoadingState());

  void fetchLogin(String userName, String password) async {
    emit(LoginLoadingState());

    LoginRequest request = LoginRequest(username: userName, password: password);
    debugPrint("request for $request");

    try{
      if(! await networkInfo.isConnected){
        emit(LoginErrorState("No internet connection. Please check and try again later"));
        return;
      }
      LoginResponse loginData = await repo.fetchLogin(request);
      debugPrint("Login Res => $loginData");
      sp.setAccessToken(loginData.accessToken!);
      sp.setRefreshToken(loginData.refreshToken!);
      emit(LoginLoadedState());

    }
    catch(ex){
      debugPrint("Exception => $ex");
      String message;

      if (ex is DioException) {
        // If you're using Dio
        message = getErrorMessage(ex.response?.statusCode);
      }
      else if (ex is SocketException) {
        message = "No internet connection. Please check your network.";
      }
      else {
        message = "Something went wrong. Please try again.";
      }
      emit(LoginErrorState(message));
    }
  }

}