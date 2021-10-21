import 'package:flutter/material.dart';

class CustomPageTransition extends PageRouteBuilder {
  CustomPageTransition({required this.child, required this.direction})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  final Widget child;
  final AxisDirection direction;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
            .animate(animation));
  }

  Offset getOffset() {
    switch (direction) {
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.left:
        return Offset(-1, 0);
      case AxisDirection.right:
        return Offset(1, 0);
    }
  }
}
