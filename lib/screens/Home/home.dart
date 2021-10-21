import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:images_picker/images_picker.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/screens/Home/widgets/main_body.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:rx_pdf/screens/camera/camera_screen.dart';
import 'package:rx_pdf/screens/camera/redeigned/camera_redisgned.dart';
import 'package:rx_pdf/screens/preview/mediaFilePreview/media_file_preview.dart';
import 'package:rx_pdf/utils/create_pdf_mode.dart';
import 'package:rx_pdf/utils/current_time.dart';
import 'package:rx_pdf/utils/custom_page_builder.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Animation<double> _fabAnimation;
  late AnimationController _fabController;
  bool _isFabMenuVisible = false;

  @override
  void initState() {
    _fabController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    _fabAnimation = _fabController.curvedTweenAnimation(
      begin: 0.0,
      end: 1.0,
    );

    super.initState();
  }

  @override
  void dispose() {
    _fabController.dispose();

    super.dispose();
  }

  void _toggleFabMenu() {
    _isFabMenuVisible = !_isFabMenuVisible;

    if (_isFabMenuVisible) {
      _fabController.forward();
    } else {
      _fabController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.primaryColor == Colors.black
          ? Colors.grey.shade900
          : Colors.white,
      floatingActionButton:
          _FabMenu(animation: _fabAnimation, toggle: _toggleFabMenu),
      body: Stack(
        children: [
          MainBody(),
          _FabOverlayBackground(
              animation: _fabAnimation, onPressOut: _toggleFabMenu)
        ],
      ),
    );
  }
}

class _FabOverlayBackground extends AnimatedWidget {
  const _FabOverlayBackground({
    required Animation<double> animation,
    required this.onPressOut,
  }) : super(listenable: animation);

  final Function onPressOut;

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: animation.value == 0,
      child: InkWell(
        onTap: () {
          onPressOut();
        },
        child: Container(
            // color: context.canvasColor.withOpacity(animation.value * 0.5),
            ),
      ),
    );
  }
}

class FabItem {
  const FabItem(this.title, this.icon, {required this.onPress});

  final IconData icon;
  final void Function() onPress;
  final String title;
}

class FabMenuItem extends StatelessWidget {
  const FabMenuItem(this.item, {Key? key}) : super(key: key);

  final FabItem item;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: StadiumBorder(),
      padding: EdgeInsets.only(
        left: 24,
        right: 16,
        top: context.responsive(8),
        bottom: context.responsive(8),
      ),
      color: Colors.red,
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.1),
      elevation: 0,
      highlightElevation: 2,
      disabledColor: Colors.white,
      onPressed: item.onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            item.title,
            style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            item.icon,
            color: Theme.of(context).scaffoldBackgroundColor,
            size: 25,
          ),
        ],
      ),
    );
  }
}

class ExpandableAnimatedFAB extends AnimatedWidget {
  final List<FabItem> items;
  final void Function() onPress;

  ExpandableAnimatedFAB(this.items, this.onPress,
      {required Animation animation})
      : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  Widget _buildItem(BuildContext context, int index) {
    final screenWidth = context.screenSize.width;
    final transform = Matrix4.translationValues(
        -(screenWidth - animation.value * screenWidth) *
            ((items.length - index) / 4),
        .0,
        .0);

    return Align(
      alignment: Alignment.centerRight,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: animation.value,
          child: FabMenuItem(items[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IgnorePointer(
          ignoring: animation.value == 0,
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) =>
                SizedBox(height: context.responsive(9)),
            padding: EdgeInsets.symmetric(vertical: context.responsive(12)),
            itemCount: items.length,
            itemBuilder: _buildItem,
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.red,
          elevation: 0.0,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animation,
          ),
          onPressed: onPress,
        ),
      ],
    );
  }
}

class _FabMenu extends StatelessWidget {
  const _FabMenu({Key? key, required this.animation, required this.toggle})
      : super(key: key);

  final Animation animation;
  final void Function() toggle;

  void onPress(Function? callback) {
    toggle();

    if (callback != null) callback();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableAnimatedFAB(
      [
        FabItem(
          "Camera",
          CupertinoIcons.camera,
          onPress: () => onPress(() {
            context.navigateTo(CameraRx());
            context.read<CameraImages>().setTitle(titleAccordingToTime());
          }),
        ),
        FabItem(
          "Gallery",
          CupertinoIcons.photo,
          onPress: () => onPress(() async {
            List<Media>? res = await getImages();
            if (res != null && res.isNotEmpty) {
              // createPdfFromMedia(res, title);
              var provider = context.read<MediaImages>();

              //  ? setting the values
              provider.setMediaImagesValue(res);
              provider.setName(titleAccordingToTime());

              // ? Preview Page
              context.navigateTo(MediaFilePreview());
            }
          }),
        ),
      ],
      toggle,
      animation: animation,
    );
  }
}
