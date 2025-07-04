import 'package:flutter/material.dart';
import 'package:time_dignitor_task/Utils/AppColor.dart';

class CustomButtonDesign extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final Color? backgroundColor;
  final Color? textColor;
  final Size? minimumSize;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const CustomButtonDesign({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.backgroundColor,
    this.textColor,
    this.minimumSize,
    this.borderRadius = 6,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColorDark,
          minimumSize: minimumSize ?? const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          // Add other style properties as needed
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor ?? AppColors.white,
            // Add other text style properties as needed
          ),
        ),
      ),
    );
  }
}