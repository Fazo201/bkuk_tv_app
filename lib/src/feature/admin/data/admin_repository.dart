import 'package:bkuk_tv_app/src/core/db/app_database.dart';

abstract class AdminRepository {
  
  Future<List<BirthdayTableData>> getAllBirthdays();
  Future<void> addBirthday({required String firstName, required String lastName, required String middleName, required String department, required DateTime birthDate, required String imagePath, required String birthdayImagePath});
  Future<void> deleteBirthday(int id);


  /// 1. UNION LAW - O'zbekiston Kasaba uyushmalari qonuni
  Future<List<UnionLawTableData>> getAllUnionLaws();
  Future<void> addUnionLaw({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> deleteUnionLaw(int id);

  /// 2. UNION STATUTE - O'zbekiston Kasaba uyushmalari ustavi
  Future<List<UnionStatuteTableData>> getAllUnionStatutes();
  Future<void> addUnionStatute({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> deleteUnionStatute(int id);

  /// 3. COLLECTIVE CONTRACT - Jamoa shartnomasi
  Future<List<CollectiveContractTableData>> getAllCollectiveContracts();
  Future<void> addCollectiveContract({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> deleteCollectiveContract(int id);

  /// 4. APPLICATION TEMPLATE - Yo'llanmalar ariza namunalari
  Future<List<ApplicationTemplateTableData>> getAllApplicationTemplates();
  Future<void> addApplicationTemplate({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> deleteApplicationTemplate(int id);

  /// 5. ANNOUNCEMENTS - E'lonlar
  Future<List<AnnouncementTableData>> getAllAnnouncements();
  Future<void> addAnnouncement({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> deleteAnnouncement(int id);

  /// 6. CULTURAL INFO - Madaniy ma'rifiy ishlar
  Future<List<CulturalInfoTableData>> getAllCulturalInfo();
  Future<void> addCulturalInfo({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> deleteCulturalInfo(int id);

  /// 7. RESORT - Sihatgohlar
  Future<List<ResortTableData>> getAllResorts();
  Future<void> addResort({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> deleteResort(int id);

  /// 8. SANATORIUM - Sanatoriyalar
  Future<List<SanatoriumTableData>> getAllSanatoriums();
  Future<void> addSanatorium({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> deleteSanatorium(int id);

  /// 9. UPCOMING PLAN - Kutilayotgan rejalar
  Future<List<UpcomingPlanTableData>> getAllUpcomingPlans();
  Future<void> addUpcomingPlan({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt});
  Future<void> deleteUpcomingPlan(int id);
}