import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/collective_contract_table.dart';

part 'collective_contract_dao.g.dart';

@DriftAccessor(tables: [CollectiveContractTable])
class CollectiveContractsDao extends DatabaseAccessor<AppDatabase> with _$CollectiveContractsDaoMixin {
  CollectiveContractsDao(super.db);

  /// CREATE
  Future<int> insertCollectiveContract(CollectiveContractTableCompanion data) {
    return into(collectiveContractTable).insert(data);
  }

  /// READ ALL
  Future<List<CollectiveContractTableData>> getAllCollectiveContracts() async {
    return await select(collectiveContractTable).get();
  }

  /// READ BY ID
  Future<CollectiveContractTableData?> getCollectiveContractById(int id) async{
    return await (select(collectiveContractTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// UPDATE
  Future<bool> updateCollectiveContract(CollectiveContractTableData data) async {
    return await update(collectiveContractTable).replace(data);
  }

  /// DELETE
  Future<int> deleteCollectiveContract(int id) async {
    return await (delete(collectiveContractTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
