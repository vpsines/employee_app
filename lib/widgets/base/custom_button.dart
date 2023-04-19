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
  final EdgeInsets? padding;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.backgroundColor = const Color(0xFF1DA1F2),
      this.textColor = Colors.white,
      this.borderRadius = 10,
      this.height,
      this.width,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        // style: TextButton.styleFrom(
        //   padding: EdgeInsets.symmetric(horizontal: 21.w,vertical: 12.h),
        //     backgroundColor: backgroundColor,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(borderRadius))),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius)),
            ),
            fixedSize: width != null
                ? MaterialStateProperty.all(Size(width!, 40.h))
                : null,
            padding: padding != null
                ? MaterialStateProperty.all(padding)
                : MaterialStateProperty.all(EdgeInsets.zero)),
        child: Text(
          buttonText,
          style: GoogleFonts.roboto(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ));
  }
}
