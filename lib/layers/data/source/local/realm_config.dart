import 'package:posts_task/layers/domain/models/posts_model.dart';
import 'package:realm/realm.dart';

class RealmConfig {
  RealmConfig._();

  bool _hasBeenInitialised = false;

  static final RealmConfig _singleton = RealmConfig._();

  static RealmConfig get instance => _singleton;

  late Realm _database;

  Realm get database => _database;

  Future<void> initialize() async {
    if (_hasBeenInitialised) return;
    _hasBeenInitialised = true;
    final config = Configuration.local([FavRecipeModel.schema]);
    _database = Realm(config);
  }
}
