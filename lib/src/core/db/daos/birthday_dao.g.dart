// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'birthday_dao.dart';

// ignore_for_file: type=lint
mixin _$BirthdayDaoMixin on DatabaseAccessor<AppDatabase> {
  $BirthdayTableTable get birthdayTable => attachedDatabase.birthdayTable;
  BirthdayDaoManager get managers => BirthdayDaoManager(this);
}

class BirthdayDaoManager {
  final _$BirthdayDaoMixin _db;
  BirthdayDaoManager(this._db);
  $$BirthdayTableTableTableManager get birthdayTable =>
      $$BirthdayTableTableTableManager(_db.attachedDatabase, _db.birthdayTable);
}
