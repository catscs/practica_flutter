import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Movies extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text().withLength(min: 1, max: 100)();

  TextColumn get description => text()();

  TextColumn get path => text().withLength(min: 1, max: 100)();

  TextColumn get extension => text().withLength(min: 1, max: 5)();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Movies], daos: [MovieDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Movies])
class MovieDao extends DatabaseAccessor<AppDatabase> with _$MovieDaoMixin {
  final AppDatabase db;

  MovieDao(this.db) : super(db);

  Future<void> insertAllHeroes(List<Movie> items) async {
    await batch((batch) {
      batch.insertAll(movies, items);
    });
  }

  Future<Movie> getHero(int id) {
    return (select(movies)..where((row) {
        return row.id.equals(id);
      })
    ).getSingle();
  }

  Future<List<Movie>> getAllHeroes() => select(movies).get();

  Future insertHeroes(Movie movie) =>
      into(movies).insertOnConflictUpdate(movie);

  Future<void> clearData() => delete(movies).go();
}
