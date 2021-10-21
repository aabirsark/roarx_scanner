import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/screens/camera/redeigned/widgets/app_bar_button.dart';
import 'package:rx_pdf/screens/camera/redeigned/widgets/preview_row.dart';
import 'package:rx_pdf/screens/camera/redeigned/widgets/shutter_rx.dart';
import 'package:rx_pdf/screens/preview/xFilePreview/xFilePreview.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:provider/provider.dart';

class OverlayButtons extends StatelessWidget {
  const OverlayButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 50,
                left: 15,
                child: AppBarButton(
                  onTap: () {
                    context.read<CameraImages>().resetValue();
                    context.navigateBack();
                  },
                  icon: CupertinoIcons.multiply,
                )),
            Positioned(
                top: 50,
                right: 15,
                child: AppBarButton(
                  onTap: () {
                    if (context.read<CameraImages>().cameraImages.isNotEmpty) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => XFilePreview(),
                          ));
                    }
                  },
                  icon: Icons.done,
                )),
            Positioned(
              child: ShutterRx(),
              bottom: constraints.maxHeight * 0.03,
            ),
            Positioned(
                bottom: constraints.maxHeight * 0.05,
                right: constraints.maxWidth * 0.08,
                child: AppBarButton(
                  onTap: () {},
                  iconSvg: "assets/eye.svg",
                )),
            Positioned(
              bottom: constraints.maxHeight * 0.18,
              child: PreviewRow(),
            ),
          ],
        ),
      );
    });
  }
}
