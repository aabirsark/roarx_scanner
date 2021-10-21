import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_pdf/utils/custom_page_builder.dart';

extension RxExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  EdgeInsets get padding => MediaQuery.of(this).padding;

  double get halfWidth => MediaQuery.of(this).size.width * 0.5;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double responsive(double size, {Axis axis = Axis.vertical}) {
    final currentSize =
        axis == Axis.horizontal ? screenSize.width : screenSize.height;
    final designSize = axis == Axis.horizontal
        ? AppConstants.designScreenSize.width
        : AppConstants.designScreenSize.height;

    return size * currentSize / designSize;
  }

  // ? Navigation

  void navigateTo(
    Widget page,
  ) {
    Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }

  void navigateBack() => Navigator.pop(this);

  // ? themes

  Color get canvasColor => Theme.of(this).canvasColor;
  Color get secondryColor => Theme.of(this).primaryColorLight;
  Color get primaryColor => Theme.of(this).scaffoldBackgroundColor;
}

extension RxExtensionWi on Widget {
  Widget get expanded => Expanded(child: this);
  Widget inkTap(void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: this,
    );
  }
}

class AppConstants {
  static const Size designScreenSize = Size(375, 754);
}

extension AnimationControllerX on AnimationController {
  Animation<T> curvedTweenAnimation<T>({required T begin, required T end}) {
    return Tween<T>(begin: begin, end: end).animate(CurvedAnimation(
      curve: Curves.easeInOut,
      parent: this,
    ));
  }
}
