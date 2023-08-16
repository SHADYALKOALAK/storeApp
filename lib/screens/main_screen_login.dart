import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreenLogin extends StatefulWidget {
  final String? titel;
  final String? supTitle;
  final Widget? widget;

  const MainScreenLogin({
    Key? key,
    this.titel,
    this.supTitle,
    this.widget,
  }) : super(key: key);

  @override
  State<MainScreenLogin> createState() => _MainScreenLoginState();
}

class _MainScreenLoginState extends State<MainScreenLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // clipBehavior: Clip.antiAlias,
        children: [
          SizedBox(
            width: double.infinity.w,
            height: double.infinity.h,
            child:
                Image.asset('assets/images/image_login.png', fit: BoxFit.cover),
          ),
          PositionedDirectional(
              end: 0.w,
              start: 0.w,
              top: 80.h,
              child: SvgPicture.asset('assets/icons/logo_icon.svg')),
          PositionedDirectional(
            top: 150,
            end: 0,
            start: 90,
            bottom: 0,
            child: Text(widget.titel ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.sp,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  height: 1.14,
                  letterSpacing: -1.32,
                )),
          ),
          PositionedDirectional(
            top: 200,
            end: 70,
            start: 70,
            bottom: 0,
            child: Text(
              widget.supTitle ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFA0A0A0),
                fontSize: 14.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
                height: 1.71,
                letterSpacing: -0.42,
              ),
            ),
          ),

          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            child: widget.widget!,
          ),
        ],
      ),
    );
  }
}
