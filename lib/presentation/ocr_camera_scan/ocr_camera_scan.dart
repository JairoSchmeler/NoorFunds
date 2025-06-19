import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import '../../core/app_export.dart';
import './widgets/camera_overlay_widget.dart';
import './widgets/capture_controls_widget.dart';
import './widgets/ocr_results_bottom_sheet.dart';
import './widgets/processing_overlay_widget.dart';

class OcrCameraScan extends StatefulWidget {
  const OcrCameraScan({super.key});

  @override
  State<OcrCameraScan> createState() => _OcrCameraScanState();
}

class _OcrCameraScanState extends State<OcrCameraScan>
    with TickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;
  bool _isProcessing = false;
  bool _isDocumentDetected = false;
  XFile? _capturedImage;
  XFile? _lastCapturedImage;
  late AnimationController _pulseAnimationController;
  late Animation<double> _pulseAnimation;

  // Mock OCR results
  final Map<String, dynamic> _mockOcrResults = {
    "donorName": "Ahmed Al-Rashid",
    "amount": "500.00",
    "currency": "SAR",
    "date": "2024-01-15",
    "category": "Zakat",
    "notes": "Monthly donation for mosque maintenance"
  };

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _setupAnimations();
    _simulateDocumentDetection();
  }

  void _setupAnimations() {
    _pulseAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseAnimationController,
      curve: Curves.easeInOut,
    ));
    _pulseAnimationController.repeat(reverse: true);
  }

  void _simulateDocumentDetection() {
    // Simulate document detection after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isDocumentDetected = true;
        });
      }
    });
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _cameraController = CameraController(
          _cameras.first,
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController != null && _isCameraInitialized) {
      try {
        await _cameraController!.setFlashMode(
          _isFlashOn ? FlashMode.off : FlashMode.torch,
        );
        setState(() {
          _isFlashOn = !_isFlashOn;
        });
      } catch (e) {
        debugPrint('Error toggling flash: $e');
      }
    }
  }

  Future<void> _captureImage() async {
    if (_cameraController != null && _isCameraInitialized && !_isProcessing) {
      try {
        // Haptic feedback
        HapticFeedback.mediumImpact();

        final XFile image = await _cameraController!.takePicture();
        setState(() {
          _capturedImage = image;
          _lastCapturedImage = image;
          _isProcessing = true;
        });

        // Simulate OCR processing
        await Future.delayed(const Duration(seconds: 3));

        if (mounted) {
          setState(() {
            _isProcessing = false;
          });
          _showOcrResults();
        }
      } catch (e) {
        debugPrint('Error capturing image: $e');
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showOcrResults() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OcrResultsBottomSheet(
        ocrResults: _mockOcrResults,
        capturedImage: _capturedImage,
        onSave: _saveDonationRecord,
        onRetake: _retakeImage,
      ),
    );
  }

  Future<void> _saveDonationRecord(Map<String, dynamic> donationData) async {
    if (_capturedImage != null) {
      final path = await LocalStorageService.saveImage(File(_capturedImage!.path));
      donationData['imagePath'] = path;
    }
    await DatabaseService.donationsBox.add(donationData);
    Navigator.of(context).pop(); // Close bottom sheet
    Navigator.of(context).pop(); // Return to previous screen

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Donation record saved successfully!',
          style: TextStyle(color: AppTheme.lightTheme.colorScheme.onPrimary),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _retakeImage() {
    Navigator.of(context).pop(); // Close bottom sheet
    setState(() {
      _capturedImage = null;
      _isProcessing = false;
    });
  }

  void _accessGallery() {
    // Mock gallery access
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gallery access feature coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _pulseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview
          if (_isCameraInitialized && _cameraController != null)
            Positioned.fill(
              child: CameraPreview(_cameraController!),
            )
          else
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF4CAF50),
                ),
              ),
            ),

          // Camera Overlay
          Positioned.fill(
            child: CameraOverlayWidget(
              isDocumentDetected: _isDocumentDetected,
              pulseAnimation: _pulseAnimation,
            ),
          ),

          // Top Controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close Button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: CustomIconWidget(
                      iconName: 'close',
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),

                Row(
                  children: [
                    // Flash Toggle
                    GestureDetector(
                      onTap: _toggleFlash,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: CustomIconWidget(
                          iconName: _isFlashOn ? 'flash_on' : 'flash_off',
                          color: _isFlashOn
                              ? const Color(0xFFFFD700)
                              : Colors.white,
                          size: 24,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Gallery Access
                    GestureDetector(
                      onTap: _accessGallery,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: CustomIconWidget(
                          iconName: 'photo_library',
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 32,
            left: 0,
            right: 0,
            child: CaptureControlsWidget(
              onCapture: _captureImage,
              lastCapturedImage: _lastCapturedImage,
              isProcessing: _isProcessing,
            ),
          ),

          // Processing Overlay
          if (_isProcessing)
            Positioned.fill(
              child: ProcessingOverlayWidget(),
            ),
        ],
      ),
    );
  }
}
