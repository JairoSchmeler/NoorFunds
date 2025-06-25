import 'sqlite_service.dart';
import 'auth_service.dart';

class DonationService {
  static Future<int> addDonation(Map<String, dynamic> donation) async {
    final user = await AuthService.getCurrentUser();
    if (user == null) {
      throw Exception('No logged in user');
    }
    final data = Map<String, dynamic>.from(donation);
    data['user_id'] = user['id'];
    return await SqliteService.addDonation(data);
  }

  static Future<List<Map<String, dynamic>>> getUserDonations() async {
    final user = await AuthService.getCurrentUser();
    if (user == null) {
      return [];
    }
    final rows = await SqliteService.getUserDonations(user['id'] as int);
    return rows;
  }

  static Future<void> deleteDonation(int id) async {
    await SqliteService.deleteDonation(id);
  }
}
