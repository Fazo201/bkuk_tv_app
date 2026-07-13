import 'package:drift/drift.dart';

class AnnouncementTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get description => text().nullable()();

  TextColumn get imagePath => text().nullable()();

  TextColumn get pdfPath => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}
