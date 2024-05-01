part of 'recipes_cubit.dart';

enum RecipesStates { init, loading, success, failed }

class RecipesState extends Equatable {
  const RecipesState({
    this.status = RecipesStates.init,
    this.data = const [],
    this.hasReachedMax = false,
    this.favRecipeModelList = const [],
  });

  final RecipesStates status;
  final List<RecipeModel> data;
  final bool hasReachedMax;
  final List<FavRecipeModel> favRecipeModelList;

  RecipesState copyWith({
    RecipesStates? status,
    List<RecipeModel>? data,
    bool? hasReachedMax,
    List<FavRecipeModel>? favRecipeModelList,
  }) {
    return RecipesState(
      status: status ?? this.status,
      data: data ?? this.data,
      favRecipeModelList: favRecipeModelList ?? this.favRecipeModelList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, data, hasReachedMax, favRecipeModelList];
}
