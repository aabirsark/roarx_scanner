import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:rx_pdf/screens/preview/widgets/bottom_bar.dart';
import 'package:rx_pdf/utils/create_pdf.dart';

class MediaFilePreview extends StatefulWidget {
  const MediaFilePreview({Key? key}) : super(key: key);

  @override
  _MediaFilePreviewState createState() => _MediaFilePreviewState();
}

class _MediaFilePreviewState extends State<MediaFilePreview> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor == Colors.black
          ? Colors.grey.shade900
          : Colors.white,
      appBar: buildAppBar(context),
      bottomNavigationBar: buildBottomBar(context),
      body: Container(
        child: PageView.builder(
          onPageChanged: context.read<MediaImages>().setPageNumber,
          itemCount: context.watch<MediaImages>().mediaImage.length,
          itemBuilder: (context, index) {
            Media imageFile =
                context.watch<MediaImages>().mediaImage.elementAt(index);
            return Container(
                child: FadeInImage(
                    placeholder: AssetImage("assets/logo.png"),
                    image: FileImage(File(imageFile.path))));
          },
        ),
      ),
    );
  }

  Container buildBottomBar(BuildContext context) {
    return Container(
      height: context.responsive(65),
      width: double.infinity,
      child: BottomBar(
        deleteOnTap: () {
          print("tapped");
          if (context.read<MediaImages>().mediaImage.length == 1) {
            context.navigateBack();
            context.read<MediaImages>().deleteCurrentPage();
          } else {
            context.read<MediaImages>().deleteCurrentPage();
          }
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.left_chevron,
          color: context.primaryColor == Colors.black
              ? Colors.white
              : Colors.black,
        ),
        onPressed: () {
          context.read<MediaImages>().resetValue();
          context.navigateBack();
        },
      ),
      title: Text(
        "${context.watch<MediaImages>().pageNumber + 1} / ${context.watch<MediaImages>().mediaImage.length}",
        style: TextStyle(
            color: context.primaryColor == Colors.black
                ? Colors.white
                : Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () {
              var data = context.read<MediaImages>();
              createPdfFromMedia(data.mediaImage, data.name, context);
            },
            icon: Icon(CupertinoIcons.share,
                color: context.primaryColor == Colors.black
                    ? Colors.white
                    : Colors.black))
      ],
    );
  }
}
