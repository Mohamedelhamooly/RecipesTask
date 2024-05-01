import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:posts_task/layers/data/dto/recipe_model.dart';
import 'package:posts_task/layers/domain/models/posts_model.dart';
import 'package:posts_task/layers/presentation/pages/product_details/product_details.dart';
import 'package:posts_task/layers/presentation/pages/recipesList/controller/recipes_cubit.dart';
import 'package:posts_task/layers/presentation/pages/recipesList/widgets/image_widget.dart';
import 'package:collection/collection.dart';

class FeedListItem extends StatelessWidget {
  const FeedListItem({super.key, required this.data});

  final RecipeModel data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              model: data,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  data.name ?? '',
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                  BlocBuilder<RecipesCubit, RecipesState>(
                    builder: (context, state) {
                      FavRecipeModel? favItem = state.favRecipeModelList
                          .firstWhereOrNull(
                              (element) => element.ItemId == data.id);
                      return favItem != null
                          ? IconButton(
                              icon: Icon(
                                Icons.favorite,
                                size: 30,
                                color: Colors.grey[600],
                              ),
                              onPressed: () async {
                                context
                                    .read<RecipesCubit>()
                                    .removeRecipeFavoriteItem(data.id ?? "");
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.favorite_border_outlined,
                                size: 30,
                                color: Colors.grey[600],
                              ),
                              onPressed: () async {
                                context
                                    .read<RecipesCubit>()
                                    .setRecipeFavoriteItem(data.id ?? "");
                              },
                            );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (data.image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: ImageWidget(
                    data: data.image ?? '',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ).animate().shimmer(duration: 1.seconds).fade(duration: 1.seconds),
    );
  }
}
