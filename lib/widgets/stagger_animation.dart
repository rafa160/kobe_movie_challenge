import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;

  StaggerAnimation({this.controller})
      : buttonAnimation = Tween(begin: 320.0, end: 60.0).animate(
      CurvedAnimation(parent: controller, curve: Interval(0.0, 0.100))),
        buttonZoom = Tween(
          begin: 60.0,
          end: 1000.0,
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1, curve: Curves.bounceOut)));

  /// in charge to squeeze the button
  final Animation<double> buttonAnimation;

  ///in charge to rise the button
  final Animation<double> buttonZoom;

  /// the buildAnimation needs two parameters that I call, even though you dont need to use both it must be called
  Widget _buildAnimation(BuildContext context, Widget child) {
    return Center(
      child: InkWell(
        onTap: () {
          controller.forward();
        },
        child: _buttonReturn(context),
      ),
    );
  }

  Widget _buildInside(BuildContext context) {
    if (buttonAnimation.value > 70) {
      return Text(
        "Sign in",
        style: TextStyle(color: Colors.white),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 10.0,
      );
    }
  }

  Widget _buttonReturn(BuildContext context) {
    if (buttonZoom.value <= 70) {
      return Container(
          width: buttonAnimation.value,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color.fromRGBO(247, 64, 106, 1.0),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: _buildInside(context));
    } else {
      return Container(
        width: buttonZoom.value,
        height: buttonZoom.value,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: buttonZoom.value < 400 ? BoxShape.circle : BoxShape.rectangle),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
