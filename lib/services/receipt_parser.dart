import '../models/parsed_receipt.dart';

/// Utility responsible for parsing text extracted from donation receipts.
class ReceiptParser {
  /// Parse [rawText] from an OCR operation into a [ParsedReceipt].
  static ParsedReceipt parseReceipt(String rawText) {
    final lines = rawText.split(RegExp(r'\r?\n'));
    final lowerText = rawText.toLowerCase();

    final receiptNumber = _extractReceiptNumber(rawText);
    final date = _extractDate(rawText) ?? DateTime.now();
    final donorName = _extractFirstMatch(lines,
            RegExp(r'(?:donor|name|given by)[:\-]\s*(.+)', caseSensitive: false)) ??
        '';
    final institutionName = _extractInstitutionName(lines);
    final donationType = _extractDonationType(lowerText);
    final amount = _extractAmount(rawText) ?? 0.0;
    final purpose = _extractFirstMatch(lines,
        RegExp(r'(?:for|purpose|notes?)[:\-]\s*(.+)', caseSensitive: false));

    return ParsedReceipt(
      receiptNumber: receiptNumber,
      date: date,
      donorName: donorName,
      institutionName: institutionName,
      donationType: donationType,
      amount: amount,
      purpose: purpose,
    );
  }

  static String? _extractReceiptNumber(String text) {
    final match = RegExp(r'(?:Receipt\s*[#:]\s*|Ref[: ]?)(\w+)')
        .firstMatch(text);
    return match?.group(1);
  }

  static DateTime? _extractDate(String text) {
    final patterns = [
      RegExp(r'(\d{1,2}[\/\-]\d{1,2}[\/\-]\d{2,4})'),
      RegExp(
          r'(January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},?\s+\d{4}',
          caseSensitive: false),
    ];
    for (final pattern in patterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        final raw = match.group(0)!;
        final parsed = DateTime.tryParse(raw);
        if (parsed != null) return parsed;
        // Fallback for MM/DD/YYYY
        final alt = raw.replaceAll(RegExp(r'[^0-9/]'), '');
        final parts = alt.split('/');
        if (parts.length == 3) {
          final month = int.tryParse(parts[0]);
          final day = int.tryParse(parts[1]);
          final year = int.tryParse(parts[2]);
          if (month != null && day != null && year != null) {
            return DateTime(year, month, day);
          }
        }
      }
    }
    return null;
  }

  static String _extractInstitutionName(List<String> lines) {
    for (final line in lines.take(5)) {
      if (line.toLowerCase().contains('masjid') ||
          line.toLowerCase().contains('mosque') ||
          line.toLowerCase().contains('islamic center')) {
        return line.trim();
      }
    }
    return '';
  }

  static String _extractDonationType(String lowerText) {
    if (lowerText.contains('zakat')) return 'Zakat';
    if (lowerText.contains('sadaqah')) return 'Sadaqah';
    if (lowerText.contains('donation')) return 'General Donation';
    return '';
  }

  static double? _extractAmount(String text) {
    final match = RegExp(r'(?:Amount|Paid|Total)[: ]*\$?([\d,]+\.\d{2})')
        .firstMatch(text);
    if (match != null) {
      return double.tryParse(match.group(1)!.replaceAll(',', ''));
    }
    return null;
  }

  static String? _extractFirstMatch(List<String> lines, RegExp regExp) {
    for (final line in lines) {
      final match = regExp.firstMatch(line);
      if (match != null) {
        return match.group(1)?.trim();
      }
    }
    return null;
  }
}
