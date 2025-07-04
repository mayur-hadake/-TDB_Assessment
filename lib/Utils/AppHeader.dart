import 'package:flutter/material.dart';

import 'AppColor.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Add a title field to accept dynamic text
  final VoidCallback? onBackPressed; // Add this line

  @override
  final Size preferredSize;

  const AppHeader({super.key,
    this.onBackPressed, required this.title})
      : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColorDark /*Color.fromARGB(255, 255, 201, 4)*/,
      automaticallyImplyLeading: false,
      title: Row(

        children: [
          IconButton(
            icon: Icon(Icons.arrow_back,color: AppColors.white,),
            onPressed: onBackPressed ?? () => Navigator.pop(context), // Use callback if provided
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Recoleta',
            ),
          ),
        ],
      ),
    );
  }
}