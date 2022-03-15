import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel(
      {String? id, String? name, String? species, String? image})
      : super(id: id, name: name, species: species, image: image);

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'species': species, 'image': image};
  }

  factory CharacterModel.fromJson(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] as String,
      name: map['name'] as String,
      species: map['species'] as String,
      image: map['image'] as String,
    );
  }
    Character toEntity() =>
      Character(id: id, name: name, species: species, image: image);
}
