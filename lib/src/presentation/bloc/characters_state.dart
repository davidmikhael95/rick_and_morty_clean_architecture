part of 'characters_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object?> get props => [];
}

class CharacterInitialState extends CharacterState {}

class CharacterLoadedState extends CharacterState {
  final List<Character>? characters;

  const CharacterLoadedState({required this.characters});
  @override
  List<Object?> get props => [characters];
}
