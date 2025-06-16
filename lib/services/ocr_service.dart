import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

/// Service handling OCR text extraction using Google ML Kit.
class OcrService {
  final TextRecognizer _textRecognizer = GoogleMlKit.vision.textRecognizer();

  /// Extracts raw text from the given [imageFile].
  Future<String> extractRawText(XFile imageFile) async {
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final RecognizedText recognisedText =
        await _textRecognizer.processImage(inputImage);
    return recognisedText.text;
  }

  /// Dispose the underlying text recognizer.
  void dispose() {
    _textRecognizer.close();
  }
}
