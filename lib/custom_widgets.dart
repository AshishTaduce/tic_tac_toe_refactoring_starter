import 'package:flutter/material.dart';

class CustomIcon extends StatefulWidget {
  IconData icon;
  CustomIcon(this.icon);
  @override
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> with TickerProviderStateMixin{
  AnimationController controller1;

  @override
  void initState() {

    controller1 = AnimationController(
      duration: Duration(milliseconds: 800), vsync: this, value: 0.0,
    );
    controller1.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation animation1 = CurvedAnimation(parent: controller1, curve: Curves.easeInExpo);

    return FadeTransition(
      opacity: controller1,
      child: ScaleTransition(
        scale: Tween(begin: 2.0, end: 1.0).animate(animation1),
        child:  Icon(
          widget.icon,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}
