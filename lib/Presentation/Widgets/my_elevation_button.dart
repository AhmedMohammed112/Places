
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Common/Resources/color_manager.dart';
import 'my_text.dart';
import 'my_container.dart';

class MyElevationButton extends StatelessWidget {

      VoidCallback fun;
      String textButton;
      Color buttonColor;
      Color textColor;
      double width;
      double size;
      double widthButton;
      double heightButton;
      double radius;
      double elevation;
      Color shadowColor;
      double padding;

      MyElevationButton({Key? key, required this.fun, required this.textButton, this.buttonColor = Colors.red, this.textColor = ColorManager.white ,this.width = double.infinity, this.size = 20,this.widthButton = double.infinity,this.heightButton = 50,this.radius = 10,this.elevation = 50,this.shadowColor = Colors.white,this.padding = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightButton,
      width: widthButton,
      child: ElevatedButton( 
          onPressed: fun,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            elevation: elevation,
            foregroundColor: buttonColor,
            padding: EdgeInsets.all(padding),
          ).copyWith(

          ),
          child: Center(
            child: MyText(
              text: textButton,
                size: size,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: ColorManager.white,
                  fontSize: size,)
            ),
          ),
      ),
    );
  }
}
