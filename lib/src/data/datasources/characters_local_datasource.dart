import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/character_model.dart';
import '../../core/error/exceptions.dart';
import 'package:jabu_code_challenge/src/data/models/character_details_model.dart';

const String cachedCharacters = 'CACHED_CHARACTERS';

abstract class ICharactersLocalDataSource {
  List<CharacterModel> getLastCharacters(int page);
  Future<void> cacheCharacters(List<CharacterModel> models, int page);

  CharacterDetailsModel getCharacterDetails(int id);
  Future<void> cacheCharacterDetails(CharacterDetailsModel model);
}

class CharactersLocalDataSource implements ICharactersLocalDataSource {
  CharactersLocalDataSource(this._box);

  final Box _box;
  bool _isFirstPage(int page) => page == 1;

  @override
  Future<void> cacheCharacters(List<CharacterModel> models, int page) {
    return _isFirstPage(page)
        ? _box.put(cachedCharacters,
            json.encode(models.map((e) => e.toJson()).toList()))
        : Future.value();
  }

  @override
  List<CharacterModel> getLastCharacters(int page) {
    final modelsString = _box.get(cachedCharacters);
    if (modelsString == null) {
      throw CacheException();
    }
    return _isFirstPage(page)
        ? json
            .decode(modelsString)
            .map<CharacterModel>((e) => CharacterModel.fromJson(e))
            .toList()
        : [];
  }

  @override
  Future<void> cacheCharacterDetails(CharacterDetailsModel model) {
    return _box.put(
        '${cachedCharacters}_${model.id}', json.encode(model.toJson()));
  }

  @override
  CharacterDetailsModel getCharacterDetails(int id) {
    final modelsString = _box.get('${cachedCharacters}_$id');
    if (modelsString == null) {
      throw CacheException();
    }
    return  CharacterDetailsModel.fromJson(json.decode(modelsString));
  }
}
