import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/character.dart';
import '../datasources/characters_local_datasource.dart';
import '../datasources/characters_remote_datasource.dart';
import '../../domain/repositories/i_characters_repository.dart';
import 'package:jabu_code_challenge/src/domain/entities/character_details.dart';

class CharactersRepository implements ICharactersRepository {
  CharactersRepository(this._networkInfo, this._remoteDataSource, this._localDataSource);

  final ICharactersLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final ICharactersRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _remoteDataSource.getCharacters(page);
        final entities = models.map<Character>((e) => e.toEntity()).toList();
        await _localDataSource.cacheCharacters(models, page);
        return Right(entities);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final models = _localDataSource.getLastCharacters(page);
        final entities = models.map<Character>((e) => e.toEntity()).toList();
        return Right(entities);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, CharacterDetails>> getCharacterDetails(int id) async {
     if (await _networkInfo.isConnected) {
      try {
        final model = await _remoteDataSource.getCharacterDetails(id);
        final entities =  model.toEntity();
        await _localDataSource.cacheCharacterDetails(model);
        return Right(entities);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final model = _localDataSource.getCharacterDetails(id);
        final entities = model.toEntity();
        return Right(entities);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}