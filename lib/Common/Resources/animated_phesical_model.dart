import 'package:flutter/material.dart';
import 'package:my_places/Common/Resources/color_manager.dart';
import 'package:my_places/Common/Resources/values_manager.dart';

class AnimatedPhysicalModelExample extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Widget widget;

  const AnimatedPhysicalModelExample({required this.widget,Key? key, required this.primaryColor, required this.secondaryColor}) : super(key: key);

  @override
  State<AnimatedPhysicalModelExample> createState() => _AnimatedPhysicalModelExampleState();
}

class _AnimatedPhysicalModelExampleState extends State<AnimatedPhysicalModelExample> {


  double? _elevation;
  Color? _primaryColor;
  Color? _secondaryColor;

  @override
  void initState() {
    _primaryColor = widget.primaryColor;
    _secondaryColor = widget.secondaryColor;
    _elevation = 0;
    super.initState();
  }



  void _changeElevation()
  {
    _elevation == 0 ? _elevation = 50 : _elevation = 0;
    _primaryColor == widget.primaryColor ? _primaryColor = _secondaryColor : _primaryColor = widget.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: InkWell(
            onTapDown: (details) {
              setState(() {
                _changeElevation();
              });
            },
            onTapCancel: () {
              setState(() {
                _changeElevation();
              });
            },
            child: AnimatedPhysicalModel(
              duration: const Duration(seconds: 1),
              color: Colors.white,
              shadowColor: Colors.black,
              elevation: _elevation!,
              borderRadius: BorderRadius.circular(AppSizes.s20),
              shape: BoxShape.rectangle,
              curve: Curves.decelerate,

              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: _primaryColor,
                  borderRadius: BorderRadius.circular(AppSizes.s20),
                ),
                duration: const Duration(seconds: 1),
                child: widget.widget

              ),

            ),
          ),
        ) ;
  }
}
