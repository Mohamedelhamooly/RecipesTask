// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FavRecipeModel extends _FavRecipeModel
    with RealmEntity, RealmObjectBase, RealmObject {
  FavRecipeModel({
    String? ItemId,
  }) {
    RealmObjectBase.set(this, 'ItemId', ItemId);
  }

  FavRecipeModel._();

  @override
  String? get ItemId => RealmObjectBase.get<String>(this, 'ItemId') as String?;
  @override
  set ItemId(String? value) => RealmObjectBase.set(this, 'ItemId', value);

  @override
  Stream<RealmObjectChanges<FavRecipeModel>> get changes =>
      RealmObjectBase.getChanges<FavRecipeModel>(this);

  @override
  FavRecipeModel freeze() => RealmObjectBase.freezeObject<FavRecipeModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(FavRecipeModel._);
    return const SchemaObject(
        ObjectType.realmObject, FavRecipeModel, 'FavRecipeModel', [
      SchemaProperty('ItemId', RealmPropertyType.string, optional: true),
    ]);
  }
}
