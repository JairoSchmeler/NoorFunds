/// Model representing a parsed donation receipt.
class ParsedReceipt {
  /// Receipt or reference number if present on the document.
  final String? receiptNumber;

  /// Date of the donation.
  final DateTime date;

  /// Name of the donor as printed on the receipt.
  final String donorName;

  /// Name of the institution issuing the receipt.
  final String institutionName;

  /// Type of the donation e.g. Zakat or Sadaqah.
  final String donationType;

  /// Amount donated.
  final double amount;

  /// Optional free text describing the purpose of the donation.
  final String? purpose;

  ParsedReceipt({
    this.receiptNumber,
    required this.date,
    required this.donorName,
    required this.institutionName,
    required this.donationType,
    required this.amount,
    this.purpose,
  });
}
