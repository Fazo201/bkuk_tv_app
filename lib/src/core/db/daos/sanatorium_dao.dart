import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/sanatorium_table.dart';

part 'sanatorium_dao.g.dart';

@DriftAccessor(tables: [SanatoriumTable])
class SanatoriumsDao extends DatabaseAccessor<AppDatabase> with _$SanatoriumsDaoMixin {
  SanatoriumsDao(super.db);

  /// CREATE
  Future<int> insertSanatorium(SanatoriumTableCompanion data) {
    return into(sanatoriumTable).insert(data);
  }

  /// READ ALL
  Future<List<SanatoriumTableData>> getAllSanatoriums() async {
    return await select(sanatoriumTable).get();
  }

  /// READ BY ID
  Future<SanatoriumTableData?> getSanatoriumById(int id) async{
    return await (select(sanatoriumTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// UPDATE
  Future<bool> updateSanatorium(SanatoriumTableData data) async {
    return await update(sanatoriumTable).replace(data);
  }

  /// DELETE
  Future<int> deleteSanatorium(int id) async {
    return await (delete(sanatoriumTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
