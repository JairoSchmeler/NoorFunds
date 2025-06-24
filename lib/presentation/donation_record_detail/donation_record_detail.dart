import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/additional_details_widget.dart';
import './widgets/document_image_widget.dart';
import './widgets/donation_info_card_widget.dart';

class DonationRecordDetail extends StatefulWidget {
  const DonationRecordDetail({super.key});

  @override
  State<DonationRecordDetail> createState() => _DonationRecordDetailState();
}

class _DonationRecordDetailState extends State<DonationRecordDetail> {
  bool isEditing = false;
  late TextEditingController donorNameController;
  late TextEditingController amountController;
  late TextEditingController notesController;
  late TextEditingController receiptNumberController;

  late Map<String, dynamic> donationData;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    donationData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    donorNameController = TextEditingController(text: donationData['donorName'] ?? '');
    amountController = TextEditingController(text: donationData['amount']?.toString() ?? '');
    notesController = TextEditingController(text: donationData['notes'] ?? '');
    receiptNumberController = TextEditingController(text: donationData['receiptNumber'] ?? '');
  }

  @override
  void dispose() {
    donorNameController.dispose();
    amountController.dispose();
    notesController.dispose();
    receiptNumberController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
    HapticFeedback.lightImpact();
  }

  void _saveDonation() {
    // Validate inputs
    if (donorNameController.text.isEmpty || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: AppTheme.lightTheme.colorScheme.error,
        ),
      );
      return;
    }

    // Save logic here
    setState(() {
      isEditing = false;
    });

    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Donation record updated successfully'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _deleteDonation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Donation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to delete this donation record?'),
              SizedBox(height: 16),
              Text('Donor: ${donationData["donorName"] ?? ''}'),
              Text(
                  'Amount: ${donationData["currency"]} ${donationData["amount"]}'),
              Text('Date: ${donationData["date"]}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Donation record deleted'),
                    backgroundColor: AppTheme.lightTheme.colorScheme.error,
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.lightTheme.colorScheme.error,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _shareRecord() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Share Donation Record',
                style: AppTheme.lightTheme.textTheme.titleLarge,
              ),
              SizedBox(height: 24),
              _buildShareOption(
                icon: 'picture_as_pdf',
                title: 'PDF Receipt',
                subtitle: 'Generate and share formatted receipt',
                onTap: () {
                  Navigator.pop(context);
                  _generatePDFReceipt();
                },
              ),
              _buildShareOption(
                icon: 'text_snippet',
                title: 'Text Summary',
                subtitle: 'Share donation details as text',
                onTap: () {
                  Navigator.pop(context);
                  _shareTextSummary();
                },
              ),
              _buildShareOption(
                icon: 'data_object',
                title: 'Raw Data Export',
                subtitle: 'Export structured data',
                onTap: () {
                  Navigator.pop(context);
                  _exportRawData();
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareOption({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Color(0xFF4CAF50).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: icon,
            color: Color(0xFF4CAF50),
            size: 24,
          ),
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  void _generatePDFReceipt() {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF receipt generated and ready to share'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _shareTextSummary() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Text summary shared successfully'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _exportRawData() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Raw data exported successfully'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          'Donation Details',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (isEditing)
            IconButton(
              onPressed: _saveDonation,
              icon: CustomIconWidget(
                iconName: 'check',
                color: Colors.white,
                size: 24,
              ),
            )
          else
            IconButton(
              onPressed: _toggleEditMode,
              icon: CustomIconWidget(
                iconName: 'edit',
                color: Colors.white,
                size: 24,
              ),
            ),
          PopupMenuButton<String>(
            icon: CustomIconWidget(
              iconName: 'more_vert',
              color: Colors.white,
              size: 24,
            ),
            onSelected: (String value) {
              if (value == 'delete') {
                _deleteDonation();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'delete',
                      color: AppTheme.lightTheme.colorScheme.error,
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Delete',
                      style: TextStyle(
                        color: AppTheme.lightTheme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Document Image
              if (donationData["documentImage"] != null)
                DocumentImageWidget(
                  imageUrl: donationData["documentImage"],
                ),

              SizedBox(height: 24),

              // Donation Information Card
              DonationInfoCardWidget(
                donationData: donationData,
                isEditing: isEditing,
                donorNameController: donorNameController,
                amountController: amountController,
                notesController: notesController,
              ),

              SizedBox(height: 24),

              // Additional Details
              AdditionalDetailsWidget(
                donationData: donationData,
                isEditing: isEditing,
                receiptNumberController: receiptNumberController,
              ),

              SizedBox(height: 32),

              // Action Buttons
              ActionButtonsWidget(
                isEditing: isEditing,
                onGenerateReceipt: _generatePDFReceipt,
                onShare: _shareRecord,
                onEdit: _toggleEditMode,
                onSave: _saveDonation,
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
