import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/additional_fields_widget.dart';
import './widgets/confidence_indicator_widget.dart';
import './widgets/currency_selector_widget.dart';
import './widgets/date_picker_widget.dart';
import './widgets/document_image_widget.dart';

class OcrResultsVerification extends StatefulWidget {
  const OcrResultsVerification({super.key});

  @override
  State<OcrResultsVerification> createState() => _OcrResultsVerificationState();
}

class _OcrResultsVerificationState extends State<OcrResultsVerification> {
  final _formKey = GlobalKey<FormState>();
  final _donorNameController = TextEditingController();
  final _donationAmountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _notesController = TextEditingController();
  final _receiptNumberController = TextEditingController();

  // Mock extracted data with confidence levels
  final Map<String, dynamic> _extractedData = {
    "documentImage":
        "https://images.pexels.com/photos/6801648/pexels-photo-6801648.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "donorName": {"value": "Ahmed Al-Rashid", "confidence": 0.95},
    "donationAmount": {"value": "500.00", "confidence": 0.88},
    "date": {
      "value": DateTime.now().subtract(Duration(days: 2)),
      "confidence": 0.92
    },
    "currency": "SAR"
  };

  String _selectedCurrency = "SAR";
  DateTime _selectedDate = DateTime.now();
  bool _isHijriCalendar = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    _donorNameController.text = _extractedData["donorName"]["value"];
    _donationAmountController.text = _extractedData["donationAmount"]["value"];
    _selectedDate = _extractedData["date"]["value"];
    _selectedCurrency = _extractedData["currency"];
  }

  double _getConfidenceLevel(String field) {
    return _extractedData[field]?["confidence"] ?? 0.0;
  }

  void _saveDonation() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show success toast
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Donation record saved successfully!'),
        backgroundColor: Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    // Navigate back to dashboard
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/dashboard-home',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      DocumentImageWidget(
                        imageUrl: _extractedData["documentImage"],
                        height: 40.h,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Verify Extracted Information',
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      _buildDonorNameField(),
                      SizedBox(height: 2.h),
                      _buildDonationAmountField(),
                      SizedBox(height: 2.h),
                      _buildDateField(),
                      SizedBox(height: 3.h),
                      AdditionalFieldsWidget(
                        categoryController: _categoryController,
                        notesController: _notesController,
                        receiptNumberController: _receiptNumberController,
                      ),
                      SizedBox(height: 4.h),
                      _buildActionButtons(),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Color(0xFF2E7D32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/ocr-camera-scan'),
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'arrow_back',
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Back to Camera',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Text(
            'Verify Results',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: _isLoading ? null : _saveDonation,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              decoration: BoxDecoration(
                color: Color(0xFFFFD700),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                      ),
                    )
                  : Text(
                      'Save',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonorNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Donor Name',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 2.w),
            ConfidenceIndicatorWidget(
              confidence: _getConfidenceLevel("donorName"),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _donorNameController,
          decoration: InputDecoration(
            hintText: 'Enter donor name',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'person',
                color: Color(0xFF2E7D32),
                size: 20,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Donor name is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDonationAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Donation Amount',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 2.w),
            ConfidenceIndicatorWidget(
              confidence: _getConfidenceLevel("donationAmount"),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: _donationAmountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  hintText: 'Enter amount',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'attach_money',
                      color: Color(0xFF2E7D32),
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Amount is required';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter valid amount';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              flex: 1,
              child: CurrencySelectorWidget(
                selectedCurrency: _selectedCurrency,
                onCurrencyChanged: (currency) {
                  setState(() {
                    _selectedCurrency = currency;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Donation Date',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 2.w),
            ConfidenceIndicatorWidget(
              confidence: _getConfidenceLevel("date"),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        DatePickerWidget(
          selectedDate: _selectedDate,
          isHijriCalendar: _isHijriCalendar,
          onDateChanged: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
          onCalendarToggle: (isHijri) {
            setState(() {
              _isHijriCalendar = isHijri;
            });
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, '/ocr-camera-scan'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 3.w),
              side: BorderSide(color: Color(0xFF2E7D32)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'camera_alt',
                  color: Color(0xFF2E7D32),
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Scan Another',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveDonation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4CAF50),
              padding: EdgeInsets.symmetric(vertical: 3.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'save',
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Save Donation',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _donorNameController.dispose();
    _donationAmountController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    _receiptNumberController.dispose();
    super.dispose();
  }
}
