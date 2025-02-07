class Village {
  final int villageId;
  final int halqaId;
  final String villageName;
  final int tehsilId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic halqa;
  Village({
    required this.villageId,
    required this.halqaId,
    required this.villageName,
    required this.tehsilId,
    required this.createdAt,
    required this.updatedAt,
    this.halqa,
  });

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      villageId: json['village_id'],
      halqaId: json['halqa_id'],
      villageName: json['village_name'],
      tehsilId: json['tehsil_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      halqa: json['halqa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'village_id': villageId,
      'halqa_id': halqaId,
      'village_name': villageName,
      'tehsil_id': tehsilId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'halqa': halqa,
    };
  }

  @override
  String toString() {
    return villageName;
  }
}
