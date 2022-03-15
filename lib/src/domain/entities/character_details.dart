import 'package:equatable/equatable.dart';
import 'package:jabu_code_challenge/src/domain/entities/character.dart';
import 'package:jabu_code_challenge/src/domain/entities/source.dart';

class CharacterDetails extends Character implements Equatable {
  final String? type;
  final String? gender;
  final String? status;
  final List<Source>? episodes;
  const CharacterDetails(
      {this.type,
      this.gender,
      this.status,
      this.episodes,
      String? id,
      String? name,
      String? species,
      String? image})
      : super(id: id, name: name, species: species, image: image);

  @override
  List<Object> get props {
    return [id!, name!, type!, gender!, status!, species!, image!, episodes!];
  }

  @override
  bool get stringify => true;
}
