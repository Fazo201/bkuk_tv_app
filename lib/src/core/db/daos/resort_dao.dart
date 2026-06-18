import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/resort_table.dart';

part 'resort_dao.g.dart';

@DriftAccessor(tables: [ResortTable])
class ResortsDao extends DatabaseAccessor<AppDatabase> with _$ResortsDaoMixin {
  ResortsDao(super.db);

  /// CREATE
  Future<int> insertResort(ResortTableCompanion data) {
    return into(resortTable).insert(data);
  }

  /// READ ALL
  Future<List<ResortTableData>> getAllResorts() async {
    return await select(resortTable).get();
  }

  /// READ BY ID
  Future<ResortTableData?> getResortById(int id) async{
    return await (select(resortTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// UPDATE
  Future<bool> updateResort(ResortTableData data) async {
    return await update(resortTable).replace(data);
  }

  /// DELETE
  Future<int> deleteResort(int id) async {
    return await (delete(resortTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
