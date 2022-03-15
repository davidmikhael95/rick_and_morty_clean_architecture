import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/i_characters_repository.dart';
import 'package:jabu_code_challenge/src/domain/entities/character_details.dart';


class GetCharacterDetailsUseCase extends UseCase<CharacterDetails, CharacterDetailsParams> {
  GetCharacterDetailsUseCase(this.repository);

  final ICharactersRepository repository;

  @override
  Future<Either<Failure, CharacterDetails>> call(CharacterDetailsParams params) {
    return repository.getCharacterDetails(params.id);
  }
}

class CharacterDetailsParams {
  CharacterDetailsParams(this.id);

  final int id;
}
