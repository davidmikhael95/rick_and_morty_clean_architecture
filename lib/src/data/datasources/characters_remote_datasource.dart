import '../models/character_model.dart';
import '../../core/util/gql_query.dart';
import '../../core/error/exceptions.dart' as excep;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jabu_code_challenge/src/data/models/character_details_model.dart';

abstract class ICharactersRemoteDataSource {
  Future<List<CharacterModel>> getCharacters(int page);
  Future<CharacterDetailsModel> getCharacterDetails(int id);
}

class CharactersRemoteDataSource implements ICharactersRemoteDataSource {
  CharactersRemoteDataSource(this._client);

  final GraphQLClient _client;

  @override
  Future<List<CharacterModel>> getCharacters(int page) async {
    try {
      final result = await _client.query(QueryOptions(
          document: gql(GqlQuery.charactersQuery), variables: {"page": page}));
      if (result.data == null) {
        return [];
      }
      return result.data?['characters']['results']
          .map((e) => CharacterModel.fromJson(e))
          .cast<CharacterModel>()
          .toList();
    } on Exception catch (exception) {
      print(exception);
      throw excep.ServerException();
    }
  }

  @override
  Future<CharacterDetailsModel> getCharacterDetails(int id) async {
    try {
      final result = await _client.query(QueryOptions(
          document: gql(GqlQuery.characterDetailsQuery),
          variables: {"id": id}));
      if (result.data == null) {
        return CharacterDetailsModel();
      }
      return CharacterDetailsModel.fromJson(result.data?['character']);
    } on Exception catch (exception) {
      print(exception);
      throw excep.ServerException();
    }
  }
}
