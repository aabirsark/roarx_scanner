import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:provider/provider.dart';

class AppBarButton extends StatefulWidget {
  const AppBarButton({Key? key, this.icon, required this.onTap, this.iconSvg})
      : super(key: key);

  final IconData? icon;
  final String? iconSvg;
  final VoidCallback onTap;

  @override
  State<AppBarButton> createState() => _AppBarButtonState();
}

class _AppBarButtonState extends State<AppBarButton> {
  bool _eyeClose = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: context.watch<CameraImages>().visible,
        child: GestureDetector(
          onTap: () {
            if (widget.iconSvg == null)
              widget.onTap();
            else {
              setState(() {
                _eyeClose = !_eyeClose;
              });
              context.read<CameraImages>().previewVisibleState();
            }
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: context.primaryColor == Colors.black
                      ? Colors.white
                      : Colors.black),
              color: context.secondryColor,
            ),
            child: Center(
              child: widget.iconSvg == null
                  ? Icon(
                      widget.icon ?? CupertinoIcons.nosign,
                      color: context.primaryColor == Colors.black
                          ? Colors.white
                          : Colors.black,
                    )
                  : AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                      child: !_eyeClose
                          ? SvgPicture.asset(
                              widget.iconSvg ?? "",
                              color: context.primaryColor == Colors.black
                                  ? Colors.white
                                  : Colors.black,
                              key: ValueKey("Open"),
                            )
                          : SvgPicture.asset("assets/eye-off.svg",
                              color: context.primaryColor == Colors.black
                                  ? Colors.white
                                  : Colors.black,
                              key: ValueKey("Close"))),
            ),
          ),
        ));
  }
}
