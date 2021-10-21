import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:rx_pdf/screens/preview/widgets/bottom_bar.dart';

import 'package:rx_pdf/utils/create_pdf.dart';

class XFilePreview extends StatefulWidget {
  const XFilePreview({Key? key}) : super(key: key);

  @override
  _XFilePreviewState createState() => _XFilePreviewState();
}

class _XFilePreviewState extends State<XFilePreview> {
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
          controller: _pageController,
          onPageChanged: (value) {
            context.read<CameraImages>().setPageNumber(value);
          },
          itemCount: context.watch<CameraImages>().cameraImages.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            XFile image = context.watch<CameraImages>().cameraImages[index];
            return Container(
              child: FadeInImage(
                  placeholder: AssetImage("assets/logo.png"),
                  image: FileImage(File(image.path))),
            );
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
          if (context.read<CameraImages>().cameraImages.length == 1) {
            context.navigateBack();
            context.read<CameraImages>().removeCurrentImage();
          } else {
            context.read<CameraImages>().removeCurrentImage();
          }
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            context.read<CameraImages>().resetValue();
            context.navigateBack();
          },
          icon: Icon(
            CupertinoIcons.left_chevron,
            size: 30,
            color: context.primaryColor == Colors.black
                ? Colors.white
                : Colors.black,
          )),
      title: Text(
        "${context.watch<CameraImages>().pageNumber + 1} / ${context.watch<CameraImages>().cameraImages.length}",
        style: TextStyle(
            color: context.primaryColor == Colors.black
                ? Colors.white
                : Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () {
              var data = context.read<CameraImages>();
              createPDFfromXFile(data.cameraImages, data.title, context);
            },
            icon: Icon(
              CupertinoIcons.share,
              color: context.primaryColor == Colors.black
                  ? Colors.white
                  : Colors.black,
            ))
      ],
    );
  }
}
