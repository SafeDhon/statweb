import 'dart:convert';

class UserModel {
  final String name;
  final String surname;
  final String typeuser;
  final String year;
  UserModel({
    required this.name,
    required this.surname,
    required this.typeuser,
    required this.year,
  });
  

  UserModel copyWith({
    String? name,
    String? surname,
    String? typeuser,
    String? year,
  }) {
    return UserModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      typeuser: typeuser ?? this.typeuser,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'typeuser': typeuser,
      'year': year,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      typeuser: map['typeuser'] ?? '',
      year: map['year'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, surname: $surname, typeuser: $typeuser, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.name == name &&
      other.surname == surname &&
      other.typeuser == typeuser &&
      other.year == year;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      surname.hashCode ^
      typeuser.hashCode ^
      year.hashCode;
  }
}
