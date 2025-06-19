import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  /// Saves [image] to a secure application directory.
  ///
  /// Returns the file path where the image was stored.
  static Future<String> saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final scansDir = Directory('${directory.path}/scans');
    if (!await scansDir.exists()) {
      await scansDir.create(recursive: true);
    }
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final extension = image.path.split('.').last;
    final storedImage = await image.copy('${scansDir.path}/$fileName.$extension');
    return storedImage.path;
  }
}
