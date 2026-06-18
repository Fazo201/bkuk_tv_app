import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/union_statute_table.dart';

part 'union_statute_dao.g.dart';

@DriftAccessor(tables: [UnionStatuteTable])
class UnionStatutesDao extends DatabaseAccessor<AppDatabase> with _$UnionStatutesDaoMixin {
  UnionStatutesDao(super.db);

  /// CREATE
  Future<int> insertUnionStatute(UnionStatuteTableCompanion data) {
    return into(unionStatuteTable).insert(data);
  }

  /// READ ALL
  Future<List<UnionStatuteTableData>> getAllUnionStatutes() async {
    return await select(unionStatuteTable).get();
  }

  /// READ BY ID
  Future<UnionStatuteTableData?> getUnionStatuteById(int id) async{
    return await (select(unionStatuteTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// UPDATE
  Future<bool> updateUnionStatute(UnionStatuteTableData data) async {
    return await update(unionStatuteTable).replace(data);
  }

  /// DELETE
  Future<int> deleteUnionStatute(int id) async {
    return await (delete(unionStatuteTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
