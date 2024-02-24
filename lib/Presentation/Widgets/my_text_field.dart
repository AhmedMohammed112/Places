
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_places/Common/Resources/color_manager.dart';

import 'my_container.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? validator;
  final Function(String value)? myOnFieldSubmitted;
  final Function(String value)? myOnChanged;
  final Function()? onCompleted;
  // on tap function
  final Function()? onTap;
  final FocusNode? focusNode;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  bool secureText = false;
  var type = TextInputType.text;
  double height = 70;
  int maxLine = 1;
  bool outLineBorder = true;
  Color color = Colors.white;
  double radius;
  Color borderColor = Colors.grey;
  final bool border;


  MyTextFormField({super.key,
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
        ),
      ),
    );
  }
}
