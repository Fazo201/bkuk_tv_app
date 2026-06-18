// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collective_contract_dao.dart';

// ignore_for_file: type=lint
mixin _$CollectiveContractsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CollectiveContractTableTable get collectiveContractTable =>
      attachedDatabase.collectiveContractTable;
  CollectiveContractsDaoManager get managers =>
      CollectiveContractsDaoManager(this);
}

class CollectiveContractsDaoManager {
  final _$CollectiveContractsDaoMixin _db;
  CollectiveContractsDaoManager(this._db);
  $$CollectiveContractTableTableTableManager get collectiveContractTable =>
      $$CollectiveContractTableTableTableManager(
        _db.attachedDatabase,
        _db.collectiveContractTable,
      );
}
