import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/announcement_table.dart';

part 'announcements_dao.g.dart';

@DriftAccessor(tables: [AnnouncementTable])
class AnnouncementsDao extends DatabaseAccessor<AppDatabase> with _$AnnouncementsDaoMixin {
  AnnouncementsDao(super.db);

  /// CREATE
  Future<int> insertAnnouncement(AnnouncementTableCompanion data) {
    return into(announcementTable).insert(data);
  }

  /// READ ALL
  Future<List<AnnouncementTableData>> getAllAnnouncements() async {
    return await select(announcementTable).get();
  }

  /// READ BY ID
  Future<AnnouncementTableData?> getAnnouncementById(int id) async{
    return await (select(announcementTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// UPDATE
  Future<bool> updateAnnouncement(AnnouncementTableData data) async {
    return await update(announcementTable).replace(data);
  }

  /// DELETE
  Future<int> deleteAnnouncement(int id) async {
    return await (delete(announcementTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
