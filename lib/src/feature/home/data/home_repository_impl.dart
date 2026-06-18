import 'package:bkuk_tv_app/src/core/db/app_database.dart';
import 'package:bkuk_tv_app/src/feature/home/data/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl(this.db);

  final AppDatabase db;

  @override
  Future<List<BirthdayTableData>> getAllBirthdays() {
    return db.birthdayDao.getAllBirthdays();
  }

  @override
  Future<List<AnnouncementTableData>> getAllAnnouncements() {
    return db.announcementsDao.getAllAnnouncements();
  }

  @override
  Future<List<UnionLawTableData>> getAllUnionLaws() {
    return db.unionLawDao.getAllUnionLaws();
  }

}
