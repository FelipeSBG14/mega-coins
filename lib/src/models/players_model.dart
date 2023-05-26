import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class PlayersModel {
  String? id;
  String name;
  int coins;
  PlayersModel({
    this.id,
    required this.name,
    required this.coins,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'coins': coins,
    };
  }

  factory PlayersModel.fromMap(Map<String, dynamic> map) {
    return PlayersModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      coins: map['coins'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayersModel.fromJson(String source) =>
      PlayersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlayersModel(id: $id, name: $name, coins: $coins)';
}
