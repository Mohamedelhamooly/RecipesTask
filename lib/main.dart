import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_task/core/di/injector.dart';
import 'package:posts_task/layers/data/source/local/realm_config.dart';
import 'package:posts_task/layers/presentation/base/app_root.dart';
import 'package:posts_task/layers/presentation/base/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RealmConfig.instance.initialize();
  await initializeGetIt();

  Bloc.observer =   MyBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  Animate.restartOnHotReload = true;

  runApp(
    const AppRoot(),
  );
}
