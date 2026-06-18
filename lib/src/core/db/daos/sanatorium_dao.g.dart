// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sanatorium_dao.dart';

// ignore_for_file: type=lint
mixin _$SanatoriumsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SanatoriumTableTable get sanatoriumTable => attachedDatabase.sanatoriumTable;
  SanatoriumsDaoManager get managers => SanatoriumsDaoManager(this);
}

class SanatoriumsDaoManager {
  final _$SanatoriumsDaoMixin _db;
  SanatoriumsDaoManager(this._db);
  $$SanatoriumTableTableTableManager get sanatoriumTable =>
      $$SanatoriumTableTableTableManager(
        _db.attachedDatabase,
        _db.sanatoriumTable,
      );
}
