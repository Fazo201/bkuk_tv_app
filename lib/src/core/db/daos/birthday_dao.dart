import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/birthday_table.dart';

part 'birthday_dao.g.dart';

@DriftAccessor(tables: [BirthdayTable])
class BirthdayDao extends DatabaseAccessor<AppDatabase> with _$BirthdayDaoMixin {
  BirthdayDao(super.db);

  /// CREATE
  Future<int> insertBirthday(BirthdayTableCompanion data) {
    return into(birthdayTable).insert(data);
  }

  /// READ ALL
  Future<List<BirthdayTableData>> getAllBirthdays() async {
    return await select(birthdayTable).get();
  }

  /// READ BY ID
  Future<BirthdayTableData?> getBirthdayById(int id) async {
    return await (select(birthdayTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// READ BY BIRTH DATE
  Future<List<BirthdayTableData>> getBirthdaysByDate(DateTime date) async {
    return await (select(birthdayTable)
          ..where((tbl) => tbl.birthDate.equals(date)))
        .get();
  }

  /// UPDATE
  Future<bool> updateBirthday(BirthdayTableData data) async {
    return await update(birthdayTable).replace(data);
  }

  /// DELETE
  Future<int> deleteBirthday(int id) async {
    return await (delete(birthdayTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}