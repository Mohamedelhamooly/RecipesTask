import 'package:dio/dio.dart';
import 'package:posts_task/layers/data/dto/recipe_model.dart';
import 'package:posts_task/layers/data/source/remote/app_endpoints.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET(AppEndPoints.recipes)
  Future<List<RecipeModel>> getRecipesApiCall();
}
