import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DocumentImageWidget extends StatelessWidget {
  final String? imageUrl;

  const DocumentImageWidget({
    super.key,
    this.imageUrl,
  });

  void _showFullScreenImage(BuildContext context) {
    if (imageUrl == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: CustomIconWidget(
                iconName: 'close',
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 4.0,
              child: CustomImageWidget(
                imageUrl: imageUrl!,
                width: 100.w,
                height: 80.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'image',
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Scanned Document',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Spacer(),
                if (imageUrl != null)
                  GestureDetector(
                    onTap: () => _showFullScreenImage(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFF4CAF50).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'zoom_in',
                            color: Color(0xFF4CAF50),
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'View',
                            style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (imageUrl != null)
            GestureDetector(
              onTap: () => _showFullScreenImage(context),
              child: Container(
                width: double.infinity,
                height: 200,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomImageWidget(
                    imageUrl: imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 120,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.3),
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'image_not_supported',
                    color: Colors.grey,
                    size: 32,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'No document image available',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
