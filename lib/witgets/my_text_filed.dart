import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ObscureCallBack = Function(bool _);

class MyTextField extends StatefulWidget {
  final TextEditingController editingController;
  final IconData? iconData;
  final String hint;
  final bool isSuffixIcon;
  final IconData? suffixIcon;
  final bool phoneText;
  final TextInputType? inputType;
  final bool isBorderStyle;
  final Color colorBackground;
  final Color colorHint;
  final bool isFocus;
  final int? lines;
  final bool isPassword;
  final TextInputAction? inputAction;
  final ObscureCallBack? obscureCallBack;
  final bool iSPrefixIcon;
  final bool obscure;
  final bool focsNods;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final FontWeight fontWeight;

  const MyTextField({
    required this.editingController,
    this.iconData,
    required this.hint,
    this.isSuffixIcon = false,
    this.iSPrefixIcon = false,
    this.phoneText = false,
    this.isFocus = true,
    this.isPassword = false,
    this.colorHint = Colors.white,
    this.lines = 1,
    this.fontWeight = FontWeight.bold,
    this.isBorderStyle = false,
    this.obscure = false,
    this.onChange,
    this.obscureCallBack,
    this.onSubmit,
    this.inputAction = TextInputAction.go,
    this.colorBackground = Colors.white24,
    this.inputType,
    this.suffixIcon,
    this.focsNods = false,
    super.key,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.isFocus == true ? true : false,
      keyboardType:
          widget.phoneText == true ? TextInputType.phone : widget.inputType,
      textInputAction: widget.inputAction,
      controller: widget.editingController,
      cursorColor: Theme.of(context).primaryColor,
      enabled: true,
      onSubmitted: widget.onSubmit,
      onChanged: widget.onChange,
      obscureText: widget.obscure,
      maxLines: widget.lines,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.colorBackground,
        hintText: widget.hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: widget.isBorderStyle == true
                ? BorderStyle.solid
                : BorderStyle.none,
            color: const Color(0xff9098B1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(25.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.r)),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            style: widget.isBorderStyle == true
                ? BorderStyle.solid
                : BorderStyle.none,
          ),
        ),
        hintStyle: TextStyle(
            fontSize: 15,
            color: widget.colorHint,
            fontWeight: widget.fontWeight),
        // prefix:
        prefixIcon: widget.iSPrefixIcon == true
            ? Icon(widget.iconData,
                color: widget.focsNods
                    ? Theme.of(context).primaryColor
                    : const Color(0xff9098B1))
            : null,
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () => widget.obscureCallBack!(!widget.obscure),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Icon(
                  widget.obscure ? Icons.visibility : Icons.visibility_off,
                  size: 26.h,
                  color: Colors.grey,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.all(15),
      ),
    );
  }
}
