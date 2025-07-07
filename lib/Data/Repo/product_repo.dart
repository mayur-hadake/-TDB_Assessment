

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_dignitor_task/Data/Model/product_categories.dart';
import 'package:time_dignitor_task/Data/Model/product_response.dart';
import 'package:time_dignitor_task/Data/api_service.dart';

class ProductRepo{

  ApiService api = ApiService();

  Future<ProductResponse> fetchProduct() async{

    try{
      Response response = await api.sendRequest.get("products", );
      debugPrint("Response => $response");

      final profileData = ProductResponse.fromJson(response.data);

      return profileData;

    }
    catch (ex){
      rethrow;
    }
  }

  Future<List<ProductCategories>> fetchProductCategories() async{

    try{
      Response response = await api.sendRequest.get("products/categories", );
      debugPrint("Response => $response");

      List<ProductCategories> categories = (response.data as List)
          .map((category) => ProductCategories.fromJson(category)).toList();

      return categories;

    }
    catch (ex){
      rethrow;
    }
  }

}