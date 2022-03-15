import 'package:dartz/dartz.dart';
import '../entities/character.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/i_characters_repository.dart';

class GetCharactersUseCase extends UseCase<List<Character>, CharacterParams> {
  GetCharactersUseCase(this.repository);

  final ICharactersRepository repository;

  @override
  Future<Either<Failure, List<Character>>> call(CharacterParams params) {
    return repository.getCharacters(params.page);
  }
}

class CharacterParams {
  CharacterParams(this.page);

  final int page;
}
