
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_dignitor_task/Data/Model/profile_response.dart';
import 'package:time_dignitor_task/Data/Repo/profile_repo.dart';
import 'package:time_dignitor_task/Logic/Profile/profile_state.dart';
import 'package:time_dignitor_task/Utils/NetworkErrorHandler.dart';
import 'package:time_dignitor_task/Utils/network_info.dart';
import 'package:time_dignitor_task/Utils/sharedPeferences.dart';

class ProfileCubit extends Cubit<ProfileState>{

  ProfileRepo repo = ProfileRepo();
  NetworkInfo networkInfo = NetworkInfo(Connectivity());
  SharedPre sp = SharedPre();


  ProfileCubit() : super(ProfileLoadingState());


  void fetchProfileDat() async {
    emit(ProfileLoadingState());

    try{
      if(! await networkInfo.isConnected){
        emit(ProfileErrorState("No internet connection. Please check and try again later"));
        return;
      }
      ProfileResponse profileResponse = await repo.fetchProfile();
      debugPrint("profile Res => $profileResponse");

      emit(ProfileLoadedState(profileResponse));

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
      emit(ProfileErrorState(message));
    }
  }
}