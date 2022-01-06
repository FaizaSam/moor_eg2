//https://resocoder.com/2019/06/26/moor-room-for-flutter-tables-queries-fluent-sqlite-database/

//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
//import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';

@DataClassName('Task')
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();

  /* @override
  Set<Column> get primaryKey => {id, name};*/
}

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));
  @override
  int get schemaVersion => 1;

  // All tables have getters in the generated class - we can select the tasks table
  Future<List<Task>> getAllTasks() => select(tasks).get();

  // Moor supports Streams which emit elements when the watched data changes
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Future insertTask(Task task) => into(tasks).insert(task);

  // Updates a Task with a matching primary key
  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTask(Task task) => delete(tasks).delete(task);
}
