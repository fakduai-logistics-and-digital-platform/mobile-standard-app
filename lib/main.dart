import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_standard/config/config.dart';
import 'package:mobile_app_standard/feature/home/bloc/websocket/websocket_bloc.dart';
import 'package:mobile_app_standard/feature/todo/bloc/todo_bloc.dart';
import 'package:mobile_app_standard/i18n/i18n.dart';
import 'package:mobile_app_standard/locator.dart';
import 'package:mobile_app_standard/router/router.dart';
import 'package:mobile_app_standard/shared/bloc/language/language_bloc.dart';
import 'package:mobile_app_standard/shared/bloc/language/language_state.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  await initLocator();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TodoBloc>(
        create: (context) => locator<TodoBloc>(),
      ),
      BlocProvider<WebsocketBloc>(
        create: (context) => locator<WebsocketBloc>(),
      ),
      BlocProvider<LanguageBloc>(
        create: (context) => locator<LanguageBloc>(),
      )
      // add more providers
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          supportedLocales: I18n.all,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: languageState.locale,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: PColor.primaryColor),
            useMaterial3: true,
          ),
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
