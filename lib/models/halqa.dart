class Halqa {
  final int id;
  final String halqaName;
  final int tehsilId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic district;

  Halqa({
    required this.id,
    required this.halqaName,
    required this.tehsilId,
    required this.createdAt,
    required this.updatedAt,
    this.district,
  });

  factory Halqa.fromJson(Map<String, dynamic> json) {
    return Halqa(
      id: json['id'],
      halqaName: json['halqa_name'],
      tehsilId: json['tehsil_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      district: json['district'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'halqa_name': halqaName,
      'tehsil_id': tehsilId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'district': district,
    };
  }
}
