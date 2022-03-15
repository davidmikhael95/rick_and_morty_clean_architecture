import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String? id;
  final String? name;
  final String? image;
  final String? species;

  const Character({this.species, this.id, this.name, this.image});

  @override
  List<Object> get props {
    return [id!, name!, species!, image!];
  }

  @override
  bool get stringify => true;
}
