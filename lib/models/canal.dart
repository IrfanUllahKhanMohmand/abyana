class Canal {
  final int id;
  final String canalName;
  final int villageId;
  final String villageName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Canal({
    required this.id,
    required this.canalName,
    required this.villageId,
    required this.villageName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Canal.fromJson(Map<String, dynamic> json) {
    return Canal(
      id: json['id'],
      canalName: json['canal_name'],
      villageId: json['village_id'],
      villageName: json['village']['village_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'canal_name': canalName,
      'village_id': villageId,
      'village_name': villageName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return canalName;
  }
}
