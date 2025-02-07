class Outlet {
  final int id;
  final String outletName;
  final int canalId;
  final String canalName;

  Outlet(
      {required this.id,
      required this.outletName,
      required this.canalId,
      required this.canalName});

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
      id: json['id'],
      outletName: json['outlet_name'],
      canalId: json['canal_id'],
      canalName: json['canal']['canal_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'outlet_name': outletName,
        'canal_id': canalId,
        'canal_name': canalName,
      };

  @override
  String toString() {
    return outletName;
  }
}
