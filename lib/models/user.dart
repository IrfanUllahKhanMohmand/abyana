class User {
  final int id;
  final String name;
  final String email;
  final int halqaId;
  final int roleId;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.halqaId,
    required this.roleId,
    required this.token,
  });

  factory User.fromRemoteJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      halqaId: json['user']['halqa_id'],
      roleId: json['user']['role_id'],
      token: json['token'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      halqaId: json['halqa_id'],
      roleId: json['role_id'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'halqa_id': halqaId,
      'role_id': roleId,
      'token': token,
    };
  }
}
