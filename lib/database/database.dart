import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:sqflite/sqflite.dart';

part 'database.g.dart';

@DataClassName('LocationData')
class Locations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get coordinates => text()();
}

@DriftDatabase(tables: [Locations])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ✅ Insert Location
  Future<int> insertLocation(String name, List<LatLng> coordinates) async {
    final coordinatesString = coordinates
        .map((coord) => '${coord.latitude},${coord.longitude}')
        .join('|');

    return into(locations).insert(
      LocationsCompanion.insert(
        name: name,
        coordinates: coordinatesString,
      ),
    );
  }

  Future<List<LocationData>> getAllLocations() async {
    return await select(locations).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}



class DatabaseHelper {
  static Future<void> insertHistory(
      String name, List<Map<String, dynamic>> markers) async {
    final db = await openDatabase('history.db', version: 1,
        onCreate: (db, version) {
          db.execute('''
        CREATE TABLE History(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          latitude REAL,
          longitude REAL
        )
      ''');
        });

    for (var marker in markers) {
      await db.insert('History', {
        'name': name,
        'latitude': marker['latitude'],
        'longitude': marker['longitude']
      });
    }
  }
}

