import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/screens/camera/widgets/BottomSheetWidgets/preview_image_card.dart';
import 'package:rx_pdf/screens/camera/widgets/BottomSheetWidgets/process_area.dart';
import 'package:rx_pdf/universal%20Widgets/modal.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class ImgPreviewBottomSheet extends StatelessWidget {
  // Image you pick
  final XFile image;

  // Constructor
  const ImgPreviewBottomSheet(this.image);

  @override
  Widget build(BuildContext context) {
    // saving and getting image

    return Column(
      // verticalDirection: VerticalDirection.up,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PreviewImageCard(
          file: image,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(7))),
                child: IconButton(
                    onPressed: () {
                      context.navigateBack();
                    },
                    icon: Icon(CupertinoIcons.multiply))),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(7)),
                color: Colors.white38,
              ),
              child: IconButton(
                  onPressed: () {
                    context.read<CameraImages>().addValue(image);
                    context.navigateBack();
                  },
                  icon: Icon(Icons.done)),
            )
          ],
        )
      ],
    );
  }
}
