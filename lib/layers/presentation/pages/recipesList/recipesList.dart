import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_task/core/debouncer.dart';
import 'package:posts_task/core/di/injector.dart';
import 'package:posts_task/layers/presentation/pages/recipesList/controller/recipes_cubit.dart';
import 'package:posts_task/layers/presentation/pages/recipesList/widgets/feed_widget.dart';

class RecipesList extends StatefulWidget {
  const RecipesList({super.key});

  @override
  State<RecipesList> createState() => RecipesListState();
}

class RecipesListState extends State<RecipesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => getIt<RecipesCubit>()..getRecipes(),
          child: BlocBuilder<RecipesCubit, RecipesState>(
            builder: (context, state) {
              switch (state.status) {
                case RecipesStates.init:
                case RecipesStates.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case RecipesStates.success:
                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<RecipesCubit>().getRecipes();
                    },
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 200,
                      ),
                      key: const ValueKey('posts_page_list_key'),
                      itemCount: state.data.length,
                      itemBuilder: (context, index) =>
                          index >= state.data.length
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  width: 100,
                                  child: FeedListItem(
                                    data: state.data[index],
                                  )),
                    ),
                  );
                case RecipesStates.failed:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('failed'),
                        InkWell(
                          onTap: () =>
                              context.read<RecipesCubit>()..getRecipes(),
                          child: const Text(
                            'Retry',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
