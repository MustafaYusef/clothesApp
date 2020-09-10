import 'package:moor_flutter/moor_flutter.dart';
part 'database.g.dart';

class Favourites extends Table {
  // autoincrement sets as a primary key

  IntColumn get itemId => integer().customConstraint("UNIQUE")();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get photo => text()();

  IntColumn get price => integer()();

  @override
  Set<Column> get primaryKey => {itemId};
}

class CartItems extends Table {
  // autoincrement sets as a primary key
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get photo => text()();
  TextColumn get size => text()();
  TextColumn get color => text()();
  IntColumn get price => integer()();
  IntColumn get number => integer()();
}

@UseMoor(tables: [Favourites, CartItems], daos: [FavouritesDao, CartItemsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Favourites])
class FavouritesDao extends DatabaseAccessor<AppDatabase>
    with _$FavouritesDaoMixin {
  final AppDatabase db;
  FavouritesDao(this.db) : super(db);

  Future<List<Favourite>> getAllFav() => select(favourites).get();

// select(animals)..where((a) => a.isMammal | a.amountOfLegs.equals(2));
  Future insertFav(Favourite a) => into(favourites).insert(a);
  Future updateFav(Favourite a) => update(favourites).replace(a);
  Future deletFav(Favourite a) => delete(favourites).delete(a);
  Future deletAllFav() => delete(favourites).go();
}

@UseDao(tables: [CartItems])
class CartItemsDao extends DatabaseAccessor<AppDatabase>
    with _$CartItemsDaoMixin {
  final AppDatabase db;
  CartItemsDao(this.db) : super(db);

  Future<List<CartItem>> getAllItems() => select(cartItems).get();

// select(animals)..where((a) => a.isMammal | a.amountOfLegs.equals(2));
  Future insertItem(CartItem a) => into(cartItems).insert(a);
  Future updateItem(CartItem a) => update(cartItems).replace(a);
  Future deletItem(CartItem a) => delete(cartItems).delete(a);
  Future deletAllItem() => delete(cartItems).go();
}
