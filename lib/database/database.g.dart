// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Favourite extends DataClass implements Insertable<Favourite> {
  final int itemId;
  final String name;
  final String photo;
  final int price;
  Favourite(
      {@required this.itemId,
      @required this.name,
      @required this.photo,
      @required this.price});
  factory Favourite.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Favourite(
      itemId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}item_id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      photo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}photo']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<int>(itemId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    return map;
  }

  FavouritesCompanion toCompanion(bool nullToAbsent) {
    return FavouritesCompanion(
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      photo:
          photo == null && nullToAbsent ? const Value.absent() : Value(photo),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
    );
  }

  factory Favourite.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Favourite(
      itemId: serializer.fromJson<int>(json['itemId']),
      name: serializer.fromJson<String>(json['name']),
      photo: serializer.fromJson<String>(json['photo']),
      price: serializer.fromJson<int>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<int>(itemId),
      'name': serializer.toJson<String>(name),
      'photo': serializer.toJson<String>(photo),
      'price': serializer.toJson<int>(price),
    };
  }

  Favourite copyWith({int itemId, String name, String photo, int price}) =>
      Favourite(
        itemId: itemId ?? this.itemId,
        name: name ?? this.name,
        photo: photo ?? this.photo,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('Favourite(')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('photo: $photo, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(itemId.hashCode,
      $mrjc(name.hashCode, $mrjc(photo.hashCode, price.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Favourite &&
          other.itemId == this.itemId &&
          other.name == this.name &&
          other.photo == this.photo &&
          other.price == this.price);
}

class FavouritesCompanion extends UpdateCompanion<Favourite> {
  final Value<int> itemId;
  final Value<String> name;
  final Value<String> photo;
  final Value<int> price;
  const FavouritesCompanion({
    this.itemId = const Value.absent(),
    this.name = const Value.absent(),
    this.photo = const Value.absent(),
    this.price = const Value.absent(),
  });
  FavouritesCompanion.insert({
    this.itemId = const Value.absent(),
    @required String name,
    @required String photo,
    @required int price,
  })  : name = Value(name),
        photo = Value(photo),
        price = Value(price);
  static Insertable<Favourite> custom({
    Expression<int> itemId,
    Expression<String> name,
    Expression<String> photo,
    Expression<int> price,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (name != null) 'name': name,
      if (photo != null) 'photo': photo,
      if (price != null) 'price': price,
    });
  }

  FavouritesCompanion copyWith(
      {Value<int> itemId,
      Value<String> name,
      Value<String> photo,
      Value<int> price}) {
    return FavouritesCompanion(
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavouritesCompanion(')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('photo: $photo, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $FavouritesTable extends Favourites
    with TableInfo<$FavouritesTable, Favourite> {
  final GeneratedDatabase _db;
  final String _alias;
  $FavouritesTable(this._db, [this._alias]);
  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  GeneratedIntColumn _itemId;
  @override
  GeneratedIntColumn get itemId => _itemId ??= _constructItemId();
  GeneratedIntColumn _constructItemId() {
    return GeneratedIntColumn('item_id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _photoMeta = const VerificationMeta('photo');
  GeneratedTextColumn _photo;
  @override
  GeneratedTextColumn get photo => _photo ??= _constructPhoto();
  GeneratedTextColumn _constructPhoto() {
    return GeneratedTextColumn(
      'photo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedIntColumn _price;
  @override
  GeneratedIntColumn get price => _price ??= _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn(
      'price',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [itemId, name, photo, price];
  @override
  $FavouritesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'favourites';
  @override
  final String actualTableName = 'favourites';
  @override
  VerificationContext validateIntegrity(Insertable<Favourite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id'], _itemIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(
          _photoMeta, photo.isAcceptableOrUnknown(data['photo'], _photoMeta));
    } else if (isInserting) {
      context.missing(_photoMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  Favourite map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Favourite.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FavouritesTable createAlias(String alias) {
    return $FavouritesTable(_db, alias);
  }
}

class CartItem extends DataClass implements Insertable<CartItem> {
  final int id;
  final int itemId;
  final String name;
  final String photo;
  final String size;
  final String color;
  final int price;
  final int number;
  CartItem(
      {@required this.id,
      @required this.itemId,
      @required this.name,
      @required this.photo,
      @required this.size,
      @required this.color,
      @required this.price,
      @required this.number});
  factory CartItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return CartItem(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      itemId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}item_id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      photo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}photo']),
      size: stringType.mapFromDatabaseResponse(data['${effectivePrefix}size']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      number: intType.mapFromDatabaseResponse(data['${effectivePrefix}number']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<int>(itemId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<int>(number);
    }
    return map;
  }

  CartItemsCompanion toCompanion(bool nullToAbsent) {
    return CartItemsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      photo:
          photo == null && nullToAbsent ? const Value.absent() : Value(photo),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      number:
          number == null && nullToAbsent ? const Value.absent() : Value(number),
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CartItem(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      name: serializer.fromJson<String>(json['name']),
      photo: serializer.fromJson<String>(json['photo']),
      size: serializer.fromJson<String>(json['size']),
      color: serializer.fromJson<String>(json['color']),
      price: serializer.fromJson<int>(json['price']),
      number: serializer.fromJson<int>(json['number']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'name': serializer.toJson<String>(name),
      'photo': serializer.toJson<String>(photo),
      'size': serializer.toJson<String>(size),
      'color': serializer.toJson<String>(color),
      'price': serializer.toJson<int>(price),
      'number': serializer.toJson<int>(number),
    };
  }

  CartItem copyWith(
          {int id,
          int itemId,
          String name,
          String photo,
          String size,
          String color,
          int price,
          int number}) =>
      CartItem(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        name: name ?? this.name,
        photo: photo ?? this.photo,
        size: size ?? this.size,
        color: color ?? this.color,
        price: price ?? this.price,
        number: number ?? this.number,
      );
  @override
  String toString() {
    return (StringBuffer('CartItem(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('photo: $photo, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('price: $price, ')
          ..write('number: $number')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          itemId.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  photo.hashCode,
                  $mrjc(
                      size.hashCode,
                      $mrjc(color.hashCode,
                          $mrjc(price.hashCode, number.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CartItem &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.name == this.name &&
          other.photo == this.photo &&
          other.size == this.size &&
          other.color == this.color &&
          other.price == this.price &&
          other.number == this.number);
}

class CartItemsCompanion extends UpdateCompanion<CartItem> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<String> name;
  final Value<String> photo;
  final Value<String> size;
  final Value<String> color;
  final Value<int> price;
  final Value<int> number;
  const CartItemsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.name = const Value.absent(),
    this.photo = const Value.absent(),
    this.size = const Value.absent(),
    this.color = const Value.absent(),
    this.price = const Value.absent(),
    this.number = const Value.absent(),
  });
  CartItemsCompanion.insert({
    this.id = const Value.absent(),
    @required int itemId,
    @required String name,
    @required String photo,
    @required String size,
    @required String color,
    @required int price,
    @required int number,
  })  : itemId = Value(itemId),
        name = Value(name),
        photo = Value(photo),
        size = Value(size),
        color = Value(color),
        price = Value(price),
        number = Value(number);
  static Insertable<CartItem> custom({
    Expression<int> id,
    Expression<int> itemId,
    Expression<String> name,
    Expression<String> photo,
    Expression<String> size,
    Expression<String> color,
    Expression<int> price,
    Expression<int> number,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (name != null) 'name': name,
      if (photo != null) 'photo': photo,
      if (size != null) 'size': size,
      if (color != null) 'color': color,
      if (price != null) 'price': price,
      if (number != null) 'number': number,
    });
  }

  CartItemsCompanion copyWith(
      {Value<int> id,
      Value<int> itemId,
      Value<String> name,
      Value<String> photo,
      Value<String> size,
      Value<String> color,
      Value<int> price,
      Value<int> number}) {
    return CartItemsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      size: size ?? this.size,
      color: color ?? this.color,
      price: price ?? this.price,
      number: number ?? this.number,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('photo: $photo, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('price: $price, ')
          ..write('number: $number')
          ..write(')'))
        .toString();
  }
}

class $CartItemsTable extends CartItems
    with TableInfo<$CartItemsTable, CartItem> {
  final GeneratedDatabase _db;
  final String _alias;
  $CartItemsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  GeneratedIntColumn _itemId;
  @override
  GeneratedIntColumn get itemId => _itemId ??= _constructItemId();
  GeneratedIntColumn _constructItemId() {
    return GeneratedIntColumn(
      'item_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _photoMeta = const VerificationMeta('photo');
  GeneratedTextColumn _photo;
  @override
  GeneratedTextColumn get photo => _photo ??= _constructPhoto();
  GeneratedTextColumn _constructPhoto() {
    return GeneratedTextColumn(
      'photo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  GeneratedTextColumn _size;
  @override
  GeneratedTextColumn get size => _size ??= _constructSize();
  GeneratedTextColumn _constructSize() {
    return GeneratedTextColumn(
      'size',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn(
      'color',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedIntColumn _price;
  @override
  GeneratedIntColumn get price => _price ??= _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _numberMeta = const VerificationMeta('number');
  GeneratedIntColumn _number;
  @override
  GeneratedIntColumn get number => _number ??= _constructNumber();
  GeneratedIntColumn _constructNumber() {
    return GeneratedIntColumn(
      'number',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, itemId, name, photo, size, color, price, number];
  @override
  $CartItemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cart_items';
  @override
  final String actualTableName = 'cart_items';
  @override
  VerificationContext validateIntegrity(Insertable<CartItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id'], _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(
          _photoMeta, photo.isAcceptableOrUnknown(data['photo'], _photoMeta));
    } else if (isInserting) {
      context.missing(_photoMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size'], _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color'], _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number'], _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartItem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CartItem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CartItemsTable createAlias(String alias) {
    return $CartItemsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $FavouritesTable _favourites;
  $FavouritesTable get favourites => _favourites ??= $FavouritesTable(this);
  $CartItemsTable _cartItems;
  $CartItemsTable get cartItems => _cartItems ??= $CartItemsTable(this);
  FavouritesDao _favouritesDao;
  FavouritesDao get favouritesDao =>
      _favouritesDao ??= FavouritesDao(this as AppDatabase);
  CartItemsDao _cartItemsDao;
  CartItemsDao get cartItemsDao =>
      _cartItemsDao ??= CartItemsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favourites, cartItems];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$FavouritesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FavouritesTable get favourites => attachedDatabase.favourites;
}
mixin _$CartItemsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CartItemsTable get cartItems => attachedDatabase.cartItems;
}
