import 'package:bkuk_tv_app/src/core/db/app_database.dart';

abstract class AdminRepository {

  Future<List<BirthdayTableData>> getAllBirthdays();
  Future<void> addBirthday({required String firstName, required String lastName, required String middleName, required String department, required DateTime birthDate, required String imagePath, required String birthdayImagePath});
  Future<void> deleteBirthday(int id);

  /// 1. UNION LAW
  Future<List<UnionLawTableData>> getAllUnionLaws();
  Future<void> addUnionLaw({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> updateUnionLaw({required int id, required String title, required String description, String? imagePath, String? pdfPath});
  Future<void> deleteUnionLaw(int id);

  /// 2. UNION STATUTE
  Future<List<UnionStatuteTableData>> getAllUnionStatutes();
  Future<void> addUnionStatute({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> updateUnionStatute({required int id, required String title, required String description, String? imagePath, String? pdfPath});
  Future<void> deleteUnionStatute(int id);

  /// 3. COLLECTIVE CONTRACT
  Future<List<CollectiveContractTableData>> getAllCollectiveContracts();
  Future<void> addCollectiveContract({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> updateCollectiveContract({required int id, required String title, required String description, String? imagePath, String? pdfPath});
  Future<void> deleteCollectiveContract(int id);

  /// 4. APPLICATION TEMPLATE
  Future<List<ApplicationTemplateTableData>> getAllApplicationTemplates();
  Future<void> addApplicationTemplate({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> updateApplicationTemplate({required int id, required String title, required String description, String? imagePath, String? pdfPath});
  Future<void> deleteApplicationTemplate(int id);

  /// 5. ANNOUNCEMENTS
  Future<List<AnnouncementTableData>> getAllAnnouncements();
  Future<void> addAnnouncement({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> updateAnnouncement({required int id, required String title, required String description, String? imagePath, String? pdfPath});
  Future<void> deleteAnnouncement(int id);

  /// 6. CULTURAL INFO
  Future<List<CulturalInfoTableData>> getAllCulturalInfo();
  Future<void> addCulturalInfo({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> updateCulturalInfo({required int id, required String title, required String description, String? imagePath, String? pdfPath});
  Future<void> deleteCulturalInfo(int id);

  /// 7. RESORT
  Future<List<ResortTableData>> getAllResorts();
  Future<void> addResort({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> updateResort({required int id, required String title, required String description, String? imagePath, String? pdfPath});
  Future<void> deleteResort(int id);

  /// 8. SANATORIUM
  Future<List<SanatoriumTableData>> getAllSanatoriums();
  Future<void> addSanatorium({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> updateSanatorium({required int id, required String title, required String description, String? imagePath, String? pdfPath});
  Future<void> deleteSanatorium(int id);

  /// 9. UPCOMING PLAN
  Future<List<UpcomingPlanTableData>> getAllUpcomingPlans();
  Future<void> addUpcomingPlan({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> updateUpcomingPlan({required int id, required String title, required String description, String? imagePath, String? pdfPath});
  Future<void> deleteUpcomingPlan(int id);
}