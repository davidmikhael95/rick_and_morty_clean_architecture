
import 'package:dartz/dartz.dart';
import '../entities/character.dart';
import '../../core/error/failures.dart';
import 'package:jabu_code_challenge/src/domain/entities/character_details.dart';

abstract class ICharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters(int page);
  Future<Either<Failure, CharacterDetails>> getCharacterDetails(int id);
}
