import 'package:dartz/dartz.dart';
import 'package:posts_task/layers/data/dto/recipe_model.dart';
import 'package:posts_task/layers/data/source/remote/failure/failure.dart';
import 'package:posts_task/layers/domain/models/posts_model.dart';

abstract class AppRepository {
  Future<Either<Failure, List<RecipeModel>>> getRecipesData();
}
