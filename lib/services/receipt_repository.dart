import '../models/parsed_receipt.dart';

/// Simple in-memory repository for parsed receipts.
class ReceiptRepository {
  ReceiptRepository._();

  static final ReceiptRepository instance = ReceiptRepository._();

  final List<ParsedReceipt> _receipts = [];

  List<ParsedReceipt> get receipts => List.unmodifiable(_receipts);

  void add(ParsedReceipt receipt) {
    _receipts.add(receipt);
  }

  void clear() => _receipts.clear();
}
