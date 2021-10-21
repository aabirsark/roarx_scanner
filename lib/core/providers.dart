import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:images_picker/images_picker.dart';

class CameraImages with ChangeNotifier {
  List<XFile> _cameraImages = [];
  int _pageNumber = 0;
  String _title = "";

  //
  bool _visible = true;
  bool get visible => _visible;
  void visibleState() {
    _visible = !_visible;
    notifyListeners();
  }

  //
  bool _previewRowVisible = true;
  bool get previewRowVisible => _previewRowVisible;
  void previewVisibleState() {
    _previewRowVisible = !_previewRowVisible;
    notifyListeners();
  }
  //

  int get pageNumber => _pageNumber;
  List<XFile> get cameraImages => _cameraImages;
  String get title => _title;

  void addValue(XFile file) {
    _cameraImages.add(file);
    notifyListeners();
  }

  void setPageNumber(int i) {
    _pageNumber = i;
    notifyListeners();
  }

  void removeCurrentImage() {
    _cameraImages.removeAt(_pageNumber);
    print("removed");
    notifyListeners();
  }

  void setTitle(String name) {
    _title = name;
  }

  void resetValue() {
    _cameraImages = [];
    _pageNumber = 0;
    _title = "";
    _previewRowVisible = true;
    notifyListeners();
  }
}

class MediaImages with ChangeNotifier {
  // ? Values
  List<Media> _mediaImages = [];
  int _pagenumber = 0;
  String _name = "";

  // ? getter

  List<Media> get mediaImage => _mediaImages;
  int get pageNumber => _pagenumber;
  String get name => _name;

  // ? setter

  void setMediaImagesValue(List<Media> media) {
    _mediaImages = media;
    notifyListeners();
  }

  void setPageNumber(int i) {
    _pagenumber = i;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
  }

  // ? process

  void deleteCurrentPage() {
    _mediaImages.removeAt(_pagenumber);
    notifyListeners();
  }

  void resetValue() {
    _mediaImages = [];
    _pagenumber = 0;
    _name = "";
    notifyListeners();
  }
}
