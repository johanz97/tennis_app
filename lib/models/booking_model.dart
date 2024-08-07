class BookingModel {
  const BookingModel({
    required this.id,
    required this.idCourt,
    required this.image,
    required this.name,
    required this.trainer,
    required this.type,
    required this.address,
    required this.date,
    required this.time,
    required this.totalCost,
  });

  factory BookingModel.fromMap(Map<String, dynamic> json) {
    return BookingModel(
      id: (json['id'] ?? '').toString(),
      idCourt: (json['id_court'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      date: DateTime.parse(json['date']?.toString() ?? ''),
      time: (json['time'] ?? '').toString(),
      totalCost: (json['total_cost'] ?? '').toString(),
      trainer: (json['trainer'] ?? '').toString(),
    );
  }

  factory BookingModel.toTest() {
    return BookingModel(
      id: '01',
      idCourt: '00',
      image: 'd',
      name: 'Test',
      trainer: '',
      type: '',
      time: '',
      totalCost: '',
      address: '',
      date: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_court': idCourt,
      'image': image,
      'name': name,
      'type': type,
      'address': address,
      'date': date,
      'time': time,
      'total_cost': totalCost,
    };
  }

  final String id;
  final String idCourt;
  final String image;
  final String name;
  final String type;
  final String address;
  final DateTime date;
  final String time;
  final String totalCost;
  final String trainer;
}
