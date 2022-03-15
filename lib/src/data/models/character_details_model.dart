import 'package:jabu_code_challenge/src/data/models/source_model.dart';
import 'package:jabu_code_challenge/src/domain/entities/character_details.dart';

class CharacterDetailsModel extends CharacterDetails {
  CharacterDetailsModel(
      {String? id,
      String? name,
      String? type,
      String? gender,
      String? status,
      String? species,
      String? image,
      List<SourceModel>? episodes})
      : super(
            id: id,
            name: name,
            type: type,
            gender: gender,
            status: status,
            species: species,
            image: image,
            episodes: episodes);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'gender': gender,
      'status': status,
      'species': species,
      'image': image,
      'episode': episodes
    };
  }

  factory CharacterDetailsModel.fromJson(Map<String, dynamic> map) {
    return CharacterDetailsModel(
        id: map['id'] as String,
        name: map['name'] as String,
        type: map['type'] as String,
        gender: map['gender'] as String,
        status: map['status'] as String,
        species: map['species'] as String,
        image: map['image'] as String,
        episodes: List<SourceModel>.from((map['episode'] as List<dynamic>)
            .map((e) => SourceModel.fromJson(e as Map<String, dynamic>))));
  }
  CharacterDetails toEntity() => CharacterDetails(
      id: id,
      name: name,
      type: type,
      gender: gender,
      status: status,
      species: species,
      image: image,
      episodes: episodes);
}