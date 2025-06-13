import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class OcrResultsBottomSheet extends StatefulWidget {
  final Map<String, dynamic> ocrResults;
  final XFile? capturedImage;
  final Function(Map<String, dynamic>) onSave;
  final VoidCallback onRetake;

  const OcrResultsBottomSheet({
    super.key,
    required this.ocrResults,
    this.capturedImage,
    required this.onSave,
    required this.onRetake,
  });

  @override
  State<OcrResultsBottomSheet> createState() => _OcrResultsBottomSheetState();
}

class _OcrResultsBottomSheetState extends State<OcrResultsBottomSheet> {
  late TextEditingController _donorNameController;
  late TextEditingController _amountController;
  late TextEditingController _notesController;
  late DateTime _selectedDate;
  String _selectedCurrency = 'SAR';
  String _selectedCategory = 'Zakat';

  final List<String> _currencies = ['SAR', 'AED', 'USD', 'EUR'];
  final List<String> _categories = [
    'Zakat',
    'Sadaqah',
    'Donation',
    'Charity',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _donorNameController = TextEditingController(
      text: widget.ocrResults['donorName'] ?? '',
    );
    _amountController = TextEditingController(
      text: widget.ocrResults['amount'] ?? '',
    );
    _notesController = TextEditingController(
      text: widget.ocrResults['notes'] ?? '',
    );
    _selectedDate =
        DateTime.tryParse(widget.ocrResults['date'] ?? '') ?? DateTime.now();
    _selectedCurrency = widget.ocrResults['currency'] ?? 'SAR';
    _selectedCategory = widget.ocrResults['category'] ?? 'Zakat';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color(0xFF4CAF50),
                  onPrimary: Colors.white,
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveDonation() {
    final donationData = {
      'donorName': _donorNameController.text,
      'amount': _amountController.text,
      'currency': _selectedCurrency,
      'date': _selectedDate.toIso8601String(),
      'category': _selectedCategory,
      'notes': _notesController.text,
    };

    widget.onSave(donationData);
  }

  @override
  void dispose() {
    _donorNameController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Verify Donation Details',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: widget.onRetake,
                      child: Text(
                        'Retake',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _saveDonation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Captured image preview
                  if (widget.capturedImage != null)
                    Container(
                      width: double.infinity,
                      height: 120,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFFD700),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomImageWidget(
                          imageUrl:
                              'https://images.pexels.com/photos/6863183/pexels-photo-6863183.jpeg?auto=compress&cs=tinysrgb&w=800',
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  // Form fields
                  _buildTextField(
                    label: 'Donor Name',
                    controller: _donorNameController,
                    icon: 'person',
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildTextField(
                          label: 'Amount',
                          controller: _amountController,
                          icon: 'attach_money',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDropdownField(
                          label: 'Currency',
                          value: _selectedCurrency,
                          items: _currencies,
                          onChanged: (value) {
                            setState(() {
                              _selectedCurrency = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildDateField(),

                  const SizedBox(height: 16),

                  _buildDropdownField(
                    label: 'Category',
                    value: _selectedCategory,
                    items: _categories,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  _buildTextField(
                    label: 'Notes (Optional)',
                    controller: _notesController,
                    icon: 'note',
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String icon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF2E7D32),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: CustomIconWidget(
              iconName: icon,
              color: const Color(0xFF4CAF50),
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF4CAF50),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.withValues(alpha: 0.05),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF2E7D32),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF4CAF50),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.withValues(alpha: 0.05),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF2E7D32),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.3),
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.withValues(alpha: 0.05),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'calendar_today',
                  color: const Color(0xFF4CAF50),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
