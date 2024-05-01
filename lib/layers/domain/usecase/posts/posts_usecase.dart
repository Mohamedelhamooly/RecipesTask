import 'package:dartz/dartz.dart';
import 'package:posts_task/layers/data/dto/recipe_model.dart';
import 'package:posts_task/layers/data/source/local/local_storage.dart';
import 'package:posts_task/layers/data/source/remote/failure/failure.dart';
import 'package:posts_task/layers/domain/models/posts_model.dart';
import 'package:posts_task/layers/domain/repository/app_repository.dart';

class RecipesUseCase {
  RecipesUseCase({
    required LocalStorage localStorage,
    required AppRepository repository,
  }) : _repository = repository , _localStorage = localStorage;

  final AppRepository _repository;
  final LocalStorage _localStorage;

  Future<Either<Failure, List<RecipeModel>>> call() async {
    return _repository.getRecipesData();
  }

  Future<List<FavRecipeModel>?> getFavItems() {
    return _localStorage.getRecipesFavoriteList();
  }

  Future<void> setRecipeFavoriteItem(String Id) async {
   await _localStorage.setRecipeFavoriteItem(Id);
  }

  Future<void>  removeRecipeFavoriteItem(String Id)async {
    await _localStorage.removeRecipeFavoriteItem(Id);
  }
}
