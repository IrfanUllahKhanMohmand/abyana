class CropPrice {
  final int id;
  final String cropPrice;
  final String finalCrop;

  CropPrice(
      {required this.id, required this.cropPrice, required this.finalCrop});

  factory CropPrice.fromJson(Map<String, dynamic> json) {
    return CropPrice(
      id: json['id'],
      cropPrice: json['crop_price'],
      finalCrop: json['final_crop'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'crop_price': cropPrice,
        'final_crop': finalCrop,
      };

  @override
  String toString() {
    return cropPrice;
  }
}
