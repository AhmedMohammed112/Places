
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_places/Common/Resources/color_manager.dart';

import 'my_container.dart';

class MyTextFormField extends StatelessWidget {
  TextEditingController controller;
  Function(String value)? validator;
  Function(String value)? myOnFieldSubmitted;
  Function(String value)? myOnChanged;
  Function()? onCompleted;
  // on tap function
  Function()? onTap;
  FocusNode? focusNode;
  Icon? prefixIcon;
  Widget? suffixIcon;
  String? labelText;
  String? hintText;
  bool secureText = false;
  var type = TextInputType.text;
  double height = 70;
  int maxLine = 1;
  bool outLineBorder = true;
  Color color = Colors.white;
  double radius;
  Color borderColor = Colors.grey;
  bool border;


  MyTextFormField({
    required this.controller,
    this.validator,
     this.myOnChanged,
      this.onTap,
     this.myOnFieldSubmitted,
      this.onCompleted,
      this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.secureText = false,
    this.type = TextInputType.text,
    this.height = 50,
    this.maxLine = 1,
    this.outLineBorder = true,
    this.color = Colors.transparent,
    this.radius = 10,
    this.borderColor = Colors.transparent,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color
      ),
      child: TextFormField(
        controller: controller,
        validator: (String? value) => validator!(value!),
        onChanged: myOnChanged,
        onTap: onTap,
        onFieldSubmitted: myOnFieldSubmitted,
        onEditingComplete: () => onCompleted!(),
        focusNode: focusNode,
        obscureText: secureText,
        keyboardType: type,
        maxLines: maxLine,
        decoration: InputDecoration(
          border: border ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ) : InputBorder.none,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          // filled: true,
          // fillColor: color,
        ),
      ),
    );
  }
}
