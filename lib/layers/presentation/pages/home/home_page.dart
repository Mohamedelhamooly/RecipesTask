import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_task/core/di/injector.dart';
import 'package:posts_task/layers/presentation/pages/recipesList/controller/recipes_cubit.dart';
import 'package:posts_task/layers/presentation/pages/recipesList/recipesList.dart';

import '../sign_in/sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              elevation: 4,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                'Recipe App!',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1200.ms, color: const Color(0xFF80DDFF))
                  .animate() // this wraps the previous Animate in another Animate
                  .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                  .slide(),
            ),
          ),
        ),
      ),
      body:  SignIn(),
      );
  }
}
