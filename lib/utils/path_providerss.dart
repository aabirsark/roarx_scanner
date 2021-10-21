import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getExternalStorageDirectory();

  return directory!.path;
}

Future<String> get tempDir async {
  final directory = await getTemporaryDirectory();

  return directory.path;
}
