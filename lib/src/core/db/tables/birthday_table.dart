import 'package:drift/drift.dart';

class BirthdayTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()(); 
  TextColumn get lastName => text()();  
  TextColumn get middleName => text()(); 
  TextColumn get department => text()();
  DateTimeColumn get birthDate => dateTime()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get birthdayImagePath => text().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}