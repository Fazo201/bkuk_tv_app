// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultural_info_dao.dart';

// ignore_for_file: type=lint
mixin _$CulturalInfoDaoMixin on DatabaseAccessor<AppDatabase> {
  $CulturalInfoTableTable get culturalInfoTable =>
      attachedDatabase.culturalInfoTable;
  CulturalInfoDaoManager get managers => CulturalInfoDaoManager(this);
}

class CulturalInfoDaoManager {
  final _$CulturalInfoDaoMixin _db;
  CulturalInfoDaoManager(this._db);
  $$CulturalInfoTableTableTableManager get culturalInfoTable =>
      $$CulturalInfoTableTableTableManager(
        _db.attachedDatabase,
        _db.culturalInfoTable,
      );
}
