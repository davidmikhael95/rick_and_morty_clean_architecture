import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_characters_usecase.dart';
import 'package:jabu_code_challenge/src/domain/entities/character_details.dart';
import 'package:jabu_code_challenge/src/domain/usecases/get_character_details_usecase.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharacterState> {
  CharactersBloc(this._getCharacter, this._getCharacterDetails) : super(CharacterInitialState());

  final GetCharactersUseCase _getCharacter;
  final GetCharacterDetailsUseCase _getCharacterDetails;


  Future<List<Character>> getCharactersInPage(int offset) async {
    final page = _getPageFromOffset(offset);
    final either = await _getCharacter(CharacterParams(page));
    return either.fold((l) => throw _getFailureAndThrowExpection(l), (r) => r);
  }

    Future<CharacterDetails> getCharacterDetails(int id) async {
    final either = await _getCharacterDetails(CharacterDetailsParams(id));
    return either.fold((l) => throw _getFailureAndThrowExpection(l), (r) => r);
  }

  int _getPageFromOffset(int offset) => offset ~/ 20 + 1;

  Exception _getFailureAndThrowExpection(Failure l) {
    if (l is ServerFailure) {
      return ServerException();
    } else if (l is CacheFailure) {
      return CacheException();
    } else {
      return UnknownException();
    }
  }
}
