import 'dart:io';

import 'package:bkuk_tv_app/src/core/db/daos/application_template_dao.dart';
import 'package:bkuk_tv_app/src/core/db/daos/birthday_dao.dart';
import 'package:bkuk_tv_app/src/core/db/daos/collective_contract_dao.dart';
import 'package:bkuk_tv_app/src/core/db/daos/cultural_info_dao.dart';
import 'package:bkuk_tv_app/src/core/db/daos/resort_dao.dart';
import 'package:bkuk_tv_app/src/core/db/daos/sanatorium_dao.dart';
import 'package:bkuk_tv_app/src/core/db/daos/union_law_dao.dart';
import 'package:bkuk_tv_app/src/core/db/daos/union_statute_dao.dart';
import 'package:bkuk_tv_app/src/core/db/daos/upcoming_plan_dao.dart';
import 'package:bkuk_tv_app/src/core/db/tables/application_template_table.dart';
import 'package:bkuk_tv_app/src/core/db/tables/birthday_table.dart';
import 'package:bkuk_tv_app/src/core/db/tables/collective_contract_table.dart';
import 'package:bkuk_tv_app/src/core/db/tables/cultural_info_table.dart';
import 'package:bkuk_tv_app/src/core/db/tables/resort_table.dart';
import 'package:bkuk_tv_app/src/core/db/tables/sanatorium_table.dart';
import 'package:bkuk_tv_app/src/core/db/tables/union_law_table.dart';
import 'package:bkuk_tv_app/src/core/db/tables/union_statute_table.dart';
import 'package:bkuk_tv_app/src/core/db/tables/upcoming_plan_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/announcements_dao.dart';
import 'tables/announcement_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
    UnionLawTable,
    UnionStatuteTable,
    CollectiveContractTable,
    ApplicationTemplateTable,
    AnnouncementTable,
    CulturalInfoTable,
    ResortTable,
    SanatoriumTable,
    UpcomingPlanTable,
    BirthdayTable,
  ], 
  daos: [
    UnionLawDao,
    UnionStatutesDao,
    CollectiveContractsDao,
    ApplicationTemplatesDao,
    AnnouncementsDao,
    CulturalInfoDao,
    ResortsDao,
    SanatoriumsDao,
    UpcomingPlansDao,
    BirthdayDao,
  ]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase _instance =
      AppDatabase._internal();

  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File(p.join(dir.path, 'uzbekneftegaz.db'));

    return NativeDatabase(file);
  });
}
