import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/cultural_info_table.dart';

part 'cultural_info_dao.g.dart';

@DriftAccessor(tables: [CulturalInfoTable])
class CulturalInfoDao extends DatabaseAccessor<AppDatabase> with _$CulturalInfoDaoMixin {
  CulturalInfoDao(super.db);

  /// CREATE
  Future<int> insertCulturalInfo(CulturalInfoTableCompanion data) {
    return into(culturalInfoTable).insert(data);
  }

  /// READ ALL
  Future<List<CulturalInfoTableData>> getAllCulturalInfos() async {
    return await select(culturalInfoTable).get();
  }

  /// READ BY ID
  Future<CulturalInfoTableData?> getCulturalInfoById(int id) async{
    return await (select(culturalInfoTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// UPDATE
  Future<bool> updateCulturalInfo(CulturalInfoTableData data) async {
    return await update(culturalInfoTable).replace(data);
  }

  /// DELETE
  Future<int> deleteCulturalInfo(int id) async {
    return await (delete(culturalInfoTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
