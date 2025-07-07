

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_dignitor_task/Data/Model/product_categories.dart';
import 'package:time_dignitor_task/Data/Model/product_response.dart';
import 'package:time_dignitor_task/Data/Repo/product_repo.dart';
import 'package:time_dignitor_task/Logic/Product/product_state.dart';
import 'package:time_dignitor_task/Utils/NetworkErrorHandler.dart';
import 'package:time_dignitor_task/Utils/network_info.dart';
import 'package:time_dignitor_task/Utils/sharedPeferences.dart';

class ProductCubit extends Cubit<ProductState>{

  ProductRepo repo = ProductRepo();
  NetworkInfo networkInfo = NetworkInfo(Connectivity());
  SharedPre sp = SharedPre();

  ProductCubit() : super(ProductLoadingState());


  void fetchProductData() async {
    emit(ProductLoadingState());

    try{
      if(! await networkInfo.isConnected){
        emit(ProductErrorState("No internet connection. Please check and try again later"));
        return;
      }
      ProductResponse productResponse = await repo.fetchProduct();
      debugPrint("profile Res => $productResponse");

      emit(ProductLoadedState(productResponse));

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
      emit(ProductErrorState(message));
    }
  }


  void fetchProductCategory() async {
    emit(ProductLoadingState());

    try{
      if(! await networkInfo.isConnected){
        emit(ProductErrorState("No internet connection. Please check and try again later"));
        return;
      }
      List<ProductCategories> productCategories = await repo.fetchProductCategories();
      debugPrint("productCategories Res => $productCategories");

      emit(ProductCategoriesLoadedState(productCategories));

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
      emit(ProductErrorState(message));
    }
  }
}