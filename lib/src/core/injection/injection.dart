import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jabu_code_challenge/src/core/network/network_info.dart';
import 'package:jabu_code_challenge/src/core/injection/register_module.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jabu_code_challenge/src/presentation/bloc/characters_bloc.dart';
import 'package:jabu_code_challenge/src/domain/usecases/get_characters_usecase.dart';
import 'package:jabu_code_challenge/src/data/repositories/characters_repository.dart';
import 'package:jabu_code_challenge/src/domain/repositories/i_characters_repository.dart';
import 'package:jabu_code_challenge/src/domain/usecases/get_character_details_usecase.dart';
import 'package:jabu_code_challenge/src/data/datasources/characters_local_datasource.dart';
import 'package:jabu_code_challenge/src/data/datasources/characters_remote_datasource.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  final gh = GetItHelper(getIt);

   var registerModule = _RegisterModule();
   await gh.lazySingletonAsync<Box<dynamic>>(() => registerModule.openBox, preResolve: true);
  gh.lazySingleton<GraphQLClient>(() => registerModule.gqlClient);
  gh.lazySingleton<ICharactersLocalDataSource>(() => CharactersLocalDataSource(getIt<Box<dynamic>>()));
  gh.lazySingleton<ICharactersRemoteDataSource>(() => CharactersRemoteDataSource(getIt<GraphQLClient>()));
  gh.lazySingleton<InternetConnectionChecker>(() => registerModule.connectionChecker);
  gh.lazySingleton<NetworkInfo>(() => NetworkInfo(getIt<InternetConnectionChecker>()));
  gh.lazySingleton<ICharactersRepository>(() => CharactersRepository(
      getIt<NetworkInfo>(),
      getIt<ICharactersRemoteDataSource>(),
      getIt<ICharactersLocalDataSource>()));
  gh.lazySingleton<GetCharactersUseCase>(() => GetCharactersUseCase(getIt<ICharactersRepository>()));
  gh.lazySingleton<GetCharacterDetailsUseCase>(() => GetCharacterDetailsUseCase(getIt<ICharactersRepository>()));

  gh.factory<CharactersBloc>(() => CharactersBloc(getIt<GetCharactersUseCase>(), getIt<GetCharacterDetailsUseCase>() ));
}

class _RegisterModule extends RegisterModule {}
