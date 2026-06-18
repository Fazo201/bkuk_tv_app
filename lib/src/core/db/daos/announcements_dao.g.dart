// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcements_dao.dart';

// ignore_for_file: type=lint
mixin _$AnnouncementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AnnouncementTableTable get announcementTable =>
      attachedDatabase.announcementTable;
  AnnouncementsDaoManager get managers => AnnouncementsDaoManager(this);
}

class AnnouncementsDaoManager {
  final _$AnnouncementsDaoMixin _db;
  AnnouncementsDaoManager(this._db);
  $$AnnouncementTableTableTableManager get announcementTable =>
      $$AnnouncementTableTableTableManager(
        _db.attachedDatabase,
        _db.announcementTable,
      );
}
