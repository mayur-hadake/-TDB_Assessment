import 'package:time_dignitor_task/Data/Model/product_categories.dart';
import 'package:time_dignitor_task/Data/Model/product_response.dart';

abstract class ProductState{

}

class ProductLoadingState extends ProductState{

}

class ProductLoadedState extends ProductState{
  ProductResponse response;
  ProductLoadedState(this.response);
}

class ProductCategoriesLoadedState extends ProductState{
  List<ProductCategories> response;
  ProductCategoriesLoadedState(this.response);
}

class ProductErrorState extends ProductState{
  String error;
  ProductErrorState (this.error);
}