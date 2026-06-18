import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/application_template_table.dart';

part 'application_template_dao.g.dart';

@DriftAccessor(tables: [ApplicationTemplateTable])
class ApplicationTemplatesDao extends DatabaseAccessor<AppDatabase> with _$ApplicationTemplatesDaoMixin {
  ApplicationTemplatesDao(super.db);

  /// CREATE
  Future<int> insertApplicationTemplate(ApplicationTemplateTableCompanion data) {
    return into(applicationTemplateTable).insert(data);
  }

  /// READ ALL
  Future<List<ApplicationTemplateTableData>> getAllApplicationTemplates() async {
    return await select(applicationTemplateTable).get();
  }

  /// READ BY ID
  Future<ApplicationTemplateTableData?> getApplicationTemplateById(int id) async{
    return await (select(applicationTemplateTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// UPDATE
  Future<bool> updateApplicationTemplate(ApplicationTemplateTableData data) async {
    return await update(applicationTemplateTable).replace(data);
  }

  /// DELETE
  Future<int> deleteApplicationTemplate(int id) async {
    return await (delete(applicationTemplateTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
