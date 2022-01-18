import 'dart:convert';

import 'package:equatable/equatable.dart';

class NFT extends Equatable {
  final int id;
  final String name;
  final String unitName;
  final int amount;
  final String url;
  const NFT({
    required this.id,
    required this.name,
    required this.unitName,
    required this.amount,
    required this.url,
  });

  NFT copyWith({
    int? id,
    String? name,
    String? unitName,
    int? amount,
    String? url,
  }) {
    return NFT(
      id: id ?? this.id,
      name: name ?? this.name,
      unitName: unitName ?? this.unitName,
      amount: amount ?? this.amount,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unitName': unitName,
      'amount': amount,
      'url': url,
    };
  }

  factory NFT.fromMap(Map<String, dynamic> map) {
    return NFT(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      unitName: map['unitName'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NFT.fromJson(String source) => NFT.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NFT(id: $id, name: $name, unitName: $unitName, amount: $amount, url: $url)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      unitName,
      amount,
      url,
    ];
  }
}
