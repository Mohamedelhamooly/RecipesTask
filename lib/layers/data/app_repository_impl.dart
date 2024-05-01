import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:posts_task/layers/data/dto/recipe_model.dart';
import 'package:posts_task/layers/data/source/local/local_storage.dart';
import 'package:posts_task/layers/data/source/remote/app_api.dart';
import 'package:posts_task/layers/data/source/remote/failure/error_handler.dart';
import 'package:posts_task/layers/data/source/remote/failure/failure.dart';
import 'package:posts_task/layers/data/source/remote/network_info.dart';
import 'package:posts_task/layers/domain/models/posts_model.dart';
import 'package:posts_task/layers/domain/repository/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  AppRepositoryImpl({
    required AppServiceClient api,
    required NetworkInfo networkInfo,
  })  : _api = api,
        _networkInfo = networkInfo;
  final AppServiceClient _api;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<RecipeModel>>> getRecipesData() async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _api.getRecipesApiCall();
        if (response.length != 0 && response.isNotEmpty) {
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE, /*response.message ??*/ ResponseMessage.DEFAULT,),);
        }
      } catch (error, stack) {
        log('$error\n$stack');
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
