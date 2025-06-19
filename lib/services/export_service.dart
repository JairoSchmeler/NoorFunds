import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';

import '../models/parsed_receipt.dart';

/// Service responsible for exporting receipts to files.
class ExportService {
  /// Export [receipts] to a CSV file located in the user's documents directory.
  Future<File> exportReceiptsToCsv(List<ParsedReceipt> receipts) async {
    final rows = <List<dynamic>>[];
    rows.add([
      'Receipt Number',
      'Date',
      'Donor Name',
      'Institution',
      'Donation Type',
      'Amount',
      'Purpose'
    ]);

    for (final r in receipts) {
      rows.add([
        r.receiptNumber ?? '',
        r.date.toIso8601String(),
        r.donorName,
        r.institutionName,
        r.donationType,
        r.amount,
        r.purpose ?? ''
      ]);
    }

    final csvData = const ListToCsvConverter().convert(rows);
    final directory = await getApplicationDocumentsDirectory();
    final file =
        File('${directory.path}/donations_${DateTime.now().millisecondsSinceEpoch}.csv');
    await file.writeAsString(csvData);
    return file;
  }

  /// Export [receipts] to an Excel file located in the user's documents directory.
  Future<File> exportReceiptsToExcel(List<ParsedReceipt> receipts) async {
    final excel = Excel.createExcel();
    final sheet = excel['Receipts'];
    sheet.appendRow([
      'Receipt Number',
      'Date',
      'Donor Name',
      'Institution',
      'Donation Type',
      'Amount',
      'Purpose'
    ]);

    for (final r in receipts) {
      sheet.appendRow([
        r.receiptNumber ?? '',
        r.date.toIso8601String(),
        r.donorName,
        r.institutionName,
        r.donationType,
        r.amount,
        r.purpose ?? ''
      ]);
    }

    final directory = await getApplicationDocumentsDirectory();
    final file =
        File('${directory.path}/donations_${DateTime.now().millisecondsSinceEpoch}.xlsx');
    await file.writeAsBytes(excel.encode()!);
    return file;
  }
}
