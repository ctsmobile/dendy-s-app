// ignore_for_file: file_names, prefer_const_constructors

import 'package:dendy_app/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final double borderWidth;
  final bool prefixIcon;
  final bool forMyOrderScreen;

  final bool autofocus;
  final bool obscureText;
  final int? maxlength;
  final bool isValidate;
  final bool isCardValidate;
  final bool isPhoneValidate;
  final bool readOnly;
  final bool forPassword;
  final bool passwordVisible;

  final FontWeight fontWeight;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? suffixIconOnTap;
  final String? Function(String? value)? validator;

  const CustomTextField(
      {Key? key,
      required this.hintText,
      this.focusNode,
      this.maxlength,
      this.textInputType,
      this.textInputAction = TextInputAction.next,
      this.autofocus = false,
      this.readOnly = false,
      this.forMyOrderScreen = false,
      this.obscureText = false,
      this.forPassword = false,
      this.passwordVisible = false,
      required this.textEditingController,
      this.textColor = whiteColor,
      this.borderColor = appThemeColor,
      this.fontSize = 18,
      this.prefixIcon = false,
      this.onFieldSubmitted,
      this.onTap,
      this.suffixIconOnTap,
      this.onChanged,
      this.isCardValidate = false,
      this.isPhoneValidate = false,
      this.isValidate = false,
      this.borderWidth = 2,
      this.validator,
      this.fontWeight = FontWeight.w500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: innerShadowColor, // darker color
            ),
            BoxShadow(
              offset: Offset(0, 4),
              spreadRadius: -2.0,

              blurRadius: 8.0,
              color: whiteColor, // darker color
            ),
            BoxShadow(
              color: innerShadowColor, // background color
              spreadRadius: -1.0,

              blurRadius: 1.0,
            ),
          ],
          borderRadius: BorderRadius.circular(35),
          // border: Border(
          //     bottom: BorderSide(color: whiteColor))
        ),
        child: TextFormField(
          focusNode: focusNode,
          autofocus: autofocus,

          controller: textEditingController,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          inputFormatters: isPhoneValidate
              ? [
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  LengthLimitingTextInputFormatter(
                      maxlength), // Limit length to 10 characters
                ]
              : null,
          // maxLength: maxlength,
          decoration: InputDecoration(
            filled: true,
            fillColor: appThemeColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: borderWidth),
              borderRadius: BorderRadius.circular(46),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: borderWidth),
              borderRadius: BorderRadius.circular(46),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(46),
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ),
            prefixIcon: prefixIcon
                ? Icon(
                    Icons.search,
                    color: blackColor,
                  )
                : null,
            hintText: hintText,
            hintStyle: GoogleFonts.amaranth(
                color: grayColor, fontSize: 16.0, fontWeight: FontWeight.w400),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: prefixIcon ? 10 : 0),
            suffixIcon: !forPassword
                ? null
                : IconButton(
                    onPressed: suffixIconOnTap,
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: blackColor,
                    )),
          ),

          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          readOnly: readOnly,
          validator: !isValidate ? null : validator!,
          onTap: onTap,
          obscureText: obscureText,
        ),
      ),
    );
  }
}
