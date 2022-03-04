import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neomorphic_pokedex/app_navigator.dart';
import 'package:neomorphic_pokedex/bloc/pokemon_bloc.dart';
import 'package:neomorphic_pokedex/bloc/pokemon_details_cubit.dart';
import 'package:neomorphic_pokedex/bloc/pokemon_event.dart';
import 'package:neomorphic_pokedex/home_screen.dart';

import 'bloc/nav_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: []);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neomorphic Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  PokemonBloc()..add(PokemonPageRequest(page: 0))),
          BlocProvider(
              create: (context) =>
                  NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
          BlocProvider(create: (context) => pokemonDetailsCubit)
        ],
        child: AppNavigator(),
      ),
    );
  }
}
