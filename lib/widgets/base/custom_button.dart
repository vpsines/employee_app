import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double? width;
  final double? height;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.backgroundColor = const Color(0xFF1DA1F2),
      this.textColor = Colors.white,
      this.borderRadius = 10,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 40.h,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius))),
          child: Text(
            buttonText,
            style: GoogleFonts.roboto(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          )),
    );
  }
}
