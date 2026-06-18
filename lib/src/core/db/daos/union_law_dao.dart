import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/union_law_table.dart';

part 'union_law_dao.g.dart';

@DriftAccessor(tables: [UnionLawTable])
class UnionLawDao extends DatabaseAccessor<AppDatabase> with _$UnionLawDaoMixin {
  UnionLawDao(super.db);

  /// CREATE
  Future<int> insertUnionLaw(UnionLawTableCompanion data) async{
    return await into(unionLawTable).insert(data);
  }

  /// READ ALL
  Future<List<UnionLawTableData>> getAllUnionLaws() async {
    return await select(unionLawTable).get();
  }

  /// READ BY ID
  Future<UnionLawTableData?> getUnionLawById(int id) async {
    return await (select(unionLawTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// UPDATE
  Future<bool> updateUnionLaw(UnionLawTableData data) async {
    return await update(unionLawTable).replace(data);
  }

  /// DELETE
  Future<int> deleteUnionLaw(int id) async {
    return await (delete(unionLawTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
