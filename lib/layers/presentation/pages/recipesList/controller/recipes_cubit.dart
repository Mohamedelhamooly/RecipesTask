import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_task/layers/data/dto/recipe_model.dart';
import 'package:posts_task/layers/domain/models/posts_model.dart';
import 'package:posts_task/layers/domain/usecase/posts/posts_usecase.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit(this.mRecipesUseCase) : super(const RecipesState());

  final RecipesUseCase mRecipesUseCase;

  Future<void> getRecipes() async {
    getRecipesFavList();
    if (state.hasReachedMax) return;
    try {
      if (state.status == RecipesStates.init) {
        final result = await mRecipesUseCase.call();

        result.fold((failure) {
          emit(state.copyWith(status: RecipesStates.failed));
        }, (data) {
          if (data.isNotEmpty) {
            emit(
              state.copyWith(
                status: RecipesStates.success,
                data: data,
                hasReachedMax: data.length < 8,
              ),
            );
          } else {
            emit(state.copyWith(hasReachedMax: true));
          }
        });
      } else {
        final result = await mRecipesUseCase.call();
        result.fold((failure) {}, (data) {
          if (data.isNotEmpty) {
            emit(
              state.copyWith(
                status: RecipesStates.success,
                data: state.data,
                hasReachedMax: data.length < 8,
              ),
            );
          } else {
            emit(state.copyWith(hasReachedMax: true));
          }
        });
      }
    } catch (error, stack) {
      log('$error\n$stack');
      emit(state.copyWith(status: RecipesStates.failed));
    }
  }
  Future<void> getRecipesFavList() async {
    final result = await mRecipesUseCase.getFavItems();
    emit(state.copyWith(favRecipeModelList: result));
  }
  Future<void>  setRecipeFavoriteItem(String Id) async{
    await mRecipesUseCase.setRecipeFavoriteItem(Id);
    await getRecipesFavList();
  }
  Future<void> removeRecipeFavoriteItem(String Id) async {
   await mRecipesUseCase.removeRecipeFavoriteItem(Id);
   await getRecipesFavList();
  }
}
