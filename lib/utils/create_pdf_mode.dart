import 'package:images_picker/images_picker.dart';

Future<List<Media>?> getImages() async {
  List<Media>? res = await ImagesPicker.pick(count: 60);
  return res == null ? null : res.reversed.toList();
}
