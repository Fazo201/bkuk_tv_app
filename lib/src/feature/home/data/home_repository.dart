import 'package:bkuk_tv_app/src/core/db/app_database.dart';

abstract class HomeRepository {

  Future<List<BirthdayTableData>> getAllBirthdays();

  Future<List<AnnouncementTableData>> getAllAnnouncements();

  Future<List<UnionLawTableData>> getAllUnionLaws();

}
