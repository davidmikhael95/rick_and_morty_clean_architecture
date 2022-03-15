import 'package:jabu_code_challenge/src/domain/entities/source.dart';

class SourceModel extends Source {
  SourceModel({String? id, String? name, Source? episodes})
      : super(id: id, name: name);

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory SourceModel.fromJson(Map<String, dynamic> map) {
    return SourceModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
  Source toEntity() => Source(id: id, name: name);
}
