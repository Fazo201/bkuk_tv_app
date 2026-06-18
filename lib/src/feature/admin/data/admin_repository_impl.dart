import 'package:bkuk_tv_app/src/core/db/app_database.dart';
import 'package:bkuk_tv_app/src/feature/admin/data/admin_repository.dart';
import 'package:drift/drift.dart';

class AdminRepositoryImpl extends AdminRepository {
  AdminRepositoryImpl();

  final AppDatabase db = AppDatabase();

  @override
  Future<List<BirthdayTableData>> getAllBirthdays() {
    return db.birthdayDao.getAllBirthdays();
  }

  @override
  Future<void> addBirthday({required String firstName, required String lastName, required String middleName, required String department, required DateTime birthDate, required String imagePath, required String birthdayImagePath}) {
    return db.birthdayDao.insertBirthday(BirthdayTableCompanion.insert(firstName: firstName, lastName: lastName, middleName: middleName, department: department, birthDate: birthDate, imagePath: Value(imagePath), birthdayImagePath: Value(birthdayImagePath)));
  }
  
  @override
  Future<void> deleteBirthday(int id) {
    return db.birthdayDao.deleteBirthday(id);
  }

  /// 1. UNION LAW
  @override
  Future<List<UnionLawTableData>> getAllUnionLaws() {
    return db.unionLawDao.getAllUnionLaws();
  }

  @override
  Future<void> addUnionLaw({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt}) async {
    await db.unionLawDao.insertUnionLaw(UnionLawTableCompanion.insert(title: title, description: Value(description), imagePath: Value(imagePath), pdfPath: Value(pdfPath), createdAt: Value(createdAt)));
  }

  @override
  Future<void> deleteUnionLaw(int id) async {
    await db.unionLawDao.deleteUnionLaw(id);
  }

  /// 2. UNION STATUTE
  @override
  Future<List<UnionStatuteTableData>> getAllUnionStatutes() {
    return db.unionStatutesDao.getAllUnionStatutes();
  }

  @override
  Future<void> addUnionStatute({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt}) async {
    await db.unionStatutesDao.insertUnionStatute(UnionStatuteTableCompanion.insert(title: title, description: Value(description), imagePath: Value(imagePath), pdfPath: Value(pdfPath), createdAt: Value(createdAt)));
  }

  @override
  Future<void> deleteUnionStatute(int id) async {
    await db.unionStatutesDao.deleteUnionStatute(id);
  }

  /// 3. COLLECTIVE CONTRACT
  @override
  Future<List<CollectiveContractTableData>> getAllCollectiveContracts() {
    return db.collectiveContractsDao.getAllCollectiveContracts();
  }

  @override
  Future<void> addCollectiveContract({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt}) async {
    await db.collectiveContractsDao.insertCollectiveContract(CollectiveContractTableCompanion.insert(title: title, description: Value(description), imagePath: Value(imagePath), pdfPath: Value(pdfPath), createdAt: Value(createdAt)));
  }

  @override
  Future<void> deleteCollectiveContract(int id) async {
    await db.collectiveContractsDao.deleteCollectiveContract(id);
  }

  /// 4. APPLICATION TEMPLATE
  @override
  Future<List<ApplicationTemplateTableData>> getAllApplicationTemplates() {
    return db.applicationTemplatesDao.getAllApplicationTemplates();
  }

  @override
  Future<void> addApplicationTemplate({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt}) async {
    await db.applicationTemplatesDao.insertApplicationTemplate(ApplicationTemplateTableCompanion.insert(title: title, description: Value(description), imagePath: Value(imagePath), pdfPath: Value(pdfPath), createdAt: Value(createdAt)));
  }

  @override
  Future<void> deleteApplicationTemplate(int id) async {
    await db.applicationTemplatesDao.deleteApplicationTemplate(id);
  }

  /// 5. ANNOUNCEMENTS
  @override
  Future<List<AnnouncementTableData>> getAllAnnouncements() {
    return db.announcementsDao.getAllAnnouncements();
  }

  @override
  Future<void> addAnnouncement({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt}) async {
    await db.announcementsDao.insertAnnouncement(AnnouncementTableCompanion.insert(title: title, description: Value(description), imagePath: Value(imagePath), pdfPath: Value(pdfPath), createdAt: Value(createdAt)));
  }

  @override
  Future<void> deleteAnnouncement(int id) async {
    await db.announcementsDao.deleteAnnouncement(id);
  }

  /// 6. CULTURAL INFO
  @override
  Future<List<CulturalInfoTableData>> getAllCulturalInfo() {
    return db.culturalInfoDao.getAllCulturalInfos();
  }

  @override
  Future<void> addCulturalInfo({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt}) async {
    await db.culturalInfoDao.insertCulturalInfo(CulturalInfoTableCompanion.insert(title: title, description: Value(description), imagePath: Value(imagePath), pdfPath: Value(pdfPath), createdAt: Value(createdAt)));
  }

  @override
  Future<void> deleteCulturalInfo(int id) async {
    await db.culturalInfoDao.deleteCulturalInfo(id);
  }

  /// 7. RESORT
  @override
  Future<List<ResortTableData>> getAllResorts() {
    return db.resortsDao.getAllResorts();
  }

  @override
  Future<void> addResort({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt}) async {
    await db.resortsDao.insertResort(ResortTableCompanion.insert(title: title, description: Value(description), imagePath: Value(imagePath), pdfPath: Value(pdfPath), createdAt: Value(createdAt)));
  }

  @override
  Future<void> deleteResort(int id) async {
    await db.resortsDao.deleteResort(id);
  }

  /// 8. SANATORIUM
  @override
  Future<List<SanatoriumTableData>> getAllSanatoriums() {
    return db.sanatoriumsDao.getAllSanatoriums();
  }

  @override
  Future<void> addSanatorium({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt}) async {
    await db.sanatoriumsDao.insertSanatorium(SanatoriumTableCompanion.insert(title: title, description: Value(description), imagePath: Value(imagePath), pdfPath: Value(pdfPath), createdAt: Value(createdAt)));
  }

  @override
  Future<void> deleteSanatorium(int id) async {
    await db.sanatoriumsDao.deleteSanatorium(id);
  }

  /// 9. UPCOMING PLAN
  @override
  Future<List<UpcomingPlanTableData>> getAllUpcomingPlans() {
    return db.upcomingPlansDao.getAllUpcomingPlans();
  }

  @override
  Future<void> addUpcomingPlan({required String title, required String description, required String imagePath, required String pdfPath, required DateTime createdAt}) async {
    await db.upcomingPlansDao.insertUpcomingPlan(UpcomingPlanTableCompanion.insert(title: title, description: Value(description), imagePath: Value(imagePath), pdfPath: Value(pdfPath), createdAt: Value(createdAt)));
  }

  @override
  Future<void> deleteUpcomingPlan(int id) async {
    await db.upcomingPlansDao.deleteUpcomingPlan(id);
  }
  
}