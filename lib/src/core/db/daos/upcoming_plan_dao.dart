import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/upcoming_plan_table.dart';

part 'upcoming_plan_dao.g.dart';

@DriftAccessor(tables: [UpcomingPlanTable])
class UpcomingPlansDao extends DatabaseAccessor<AppDatabase> with _$UpcomingPlansDaoMixin {
  UpcomingPlansDao(super.db);

  /// CREATE
  Future<int> insertUpcomingPlan(UpcomingPlanTableCompanion data) {
    return into(upcomingPlanTable).insert(data);
  }

  /// READ ALL
  Future<List<UpcomingPlanTableData>> getAllUpcomingPlans() async {
    return await select(upcomingPlanTable).get();
  }

  /// READ BY ID
  Future<UpcomingPlanTableData?> getUpcomingPlanById(int id) async{
    return await (select(upcomingPlanTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// UPDATE
  Future<bool> updateUpcomingPlan(UpcomingPlanTableData data) async {
    return await update(upcomingPlanTable).replace(data);
  }

  /// DELETE
  Future<int> deleteUpcomingPlan(int id) async {
    return await (delete(upcomingPlanTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
