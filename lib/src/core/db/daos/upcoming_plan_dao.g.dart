// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_plan_dao.dart';

// ignore_for_file: type=lint
mixin _$UpcomingPlansDaoMixin on DatabaseAccessor<AppDatabase> {
  $UpcomingPlanTableTable get upcomingPlanTable =>
      attachedDatabase.upcomingPlanTable;
  UpcomingPlansDaoManager get managers => UpcomingPlansDaoManager(this);
}

class UpcomingPlansDaoManager {
  final _$UpcomingPlansDaoMixin _db;
  UpcomingPlansDaoManager(this._db);
  $$UpcomingPlanTableTableTableManager get upcomingPlanTable =>
      $$UpcomingPlanTableTableTableManager(
        _db.attachedDatabase,
        _db.upcomingPlanTable,
      );
}
