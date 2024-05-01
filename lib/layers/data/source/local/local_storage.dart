import 'package:dartz/dartz.dart';
import 'package:posts_task/layers/data/source/local/realm_config.dart';
import 'package:posts_task/layers/domain/models/posts_model.dart';
import 'package:realm/realm.dart';
import 'package:collection/collection.dart';
const appKey = 'PostssTaskDbAppBox';

const postsBox = 'postsBox';

abstract class LocalStorage {
  Future<void> setRecipeFavoriteItem(String Id);
  Future<void> removeRecipeFavoriteItem(String Id);
  Future<List<FavRecipeModel>?> getRecipesFavoriteList();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl({
    required Realm realmDB,
  }) : _realmDB = realmDB;
  final Realm _realmDB;

  @override
  Future<List<FavRecipeModel>?> getRecipesFavoriteList() async {
    return _realmDB.all<FavRecipeModel>().toList() ?? [];
  }

  @override
  Future<void> removeRecipeFavoriteItem(String Id) async {
    List<FavRecipeModel>? listFavRecipeModel = _realmDB.all<FavRecipeModel>().toList();
    FavRecipeModel? item = listFavRecipeModel.firstWhereOrNull((element) => element.ItemId == Id);
    if (item != null )
      _realmDB.write(() {
      _realmDB.delete(item);
    });
  }

  @override
  Future<void> setRecipeFavoriteItem(String Id) async {
    List<FavRecipeModel>? listFavRecipeModel = _realmDB.all<FavRecipeModel>().toList();
    FavRecipeModel? item = listFavRecipeModel.firstWhereOrNull((element) => element.ItemId == Id);

    if (item == null ) {
      _realmDB.write(() {
        _realmDB.add(FavRecipeModel(ItemId: Id));
      });
    }
  }
}
