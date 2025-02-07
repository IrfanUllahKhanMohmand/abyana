class Crop {
  final int id;
  final String cropName;

  Crop({required this.id, required this.cropName});

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'],
      cropName: json['crop_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'crop_name': cropName,
      };

  @override
  String toString() {
    return cropName;
  }
}
