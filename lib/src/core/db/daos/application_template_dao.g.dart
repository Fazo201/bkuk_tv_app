// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_template_dao.dart';

// ignore_for_file: type=lint
mixin _$ApplicationTemplatesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ApplicationTemplateTableTable get applicationTemplateTable =>
      attachedDatabase.applicationTemplateTable;
  ApplicationTemplatesDaoManager get managers =>
      ApplicationTemplatesDaoManager(this);
}

class ApplicationTemplatesDaoManager {
  final _$ApplicationTemplatesDaoMixin _db;
  ApplicationTemplatesDaoManager(this._db);
  $$ApplicationTemplateTableTableTableManager get applicationTemplateTable =>
      $$ApplicationTemplateTableTableTableManager(
        _db.attachedDatabase,
        _db.applicationTemplateTable,
      );
}
