import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DocumentImageWidget extends StatefulWidget {
  final String imageUrl;
  final double height;

  const DocumentImageWidget({
    super.key,
    required this.imageUrl,
    required this.height,
  });

  @override
  State<DocumentImageWidget> createState() => _DocumentImageWidgetState();
}

class _DocumentImageWidgetState extends State<DocumentImageWidget> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            InteractiveViewer(
              transformationController: _transformationController,
              minScale: 1.0,
              maxScale: 4.0,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CustomImageWidget(
                  imageUrl: widget.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 2.w,
              right: 2.w,
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'zoom_in',
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Pinch to zoom',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 2.w,
              left: 2.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'check_circle',
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Document Captured',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }
}
