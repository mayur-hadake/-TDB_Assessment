import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_dignitor_task/Data/Model/product_categories.dart';
import 'package:time_dignitor_task/Data/Model/product_response.dart';
import 'package:time_dignitor_task/Logic/Product/product_cubit.dart';
import 'package:time_dignitor_task/Logic/Product/product_state.dart';
import 'package:time_dignitor_task/Utils/GlobalSnackbar.dart';
import 'package:time_dignitor_task/Utils/ProductCard.dart';
import 'package:time_dignitor_task/Utils/ProgressDialog.dart';


class ProductsListScreen extends StatefulWidget {

  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {

  List<Products> products = [];
  List<ProductCategories> categories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProductCubit>().fetchProductData();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
        ],
      ),
      body: BlocConsumer<ProductCubit,ProductState>(
          listener: (context, state) {
            if(state is ProductLoadingState){
              ProgressDialog.show(context);
            }
            if(state is ProductLoadedState){
              ProgressDialog.hide(context);
              products = state.response.products!;
            }
            if(state is ProductCategoriesLoadedState){
              ProgressDialog.hide(context);
              categories = state.response!;
            }
            if(state is ProductErrorState){
              ProgressDialog.hide(context);
              GlobalSnackbar.showError(context, state.error);
            }
          },
          builder: (context, state) {
            if(state is ProductLoadedState){
              return productListScreenUi();
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
      )
    );
  }
  Widget productListScreenUi(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}