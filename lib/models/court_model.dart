class CourtModel {
  const CourtModel({
    required this.id,
    required this.image,
    required this.name,
    required this.type,
    required this.available,
    required this.address,
    required this.cost,
  });

  factory CourtModel.fromMap(Map<String, dynamic> json) {
    return CourtModel(
      id: (json['id'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      available: (json['available'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      cost: (json['cost'] ?? '').toString(),
    );
  }

  factory CourtModel.toTest() {
    return const CourtModel(
      id: '0',
      image: '',
      name: 'Test',
      type: 'A',
      available: 'test',
      address: 'test',
      cost: 'test',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'type': type,
      'available': available,
      'address': address,
      'cost': cost,
    };
  }

  final String id;
  final String image;
  final String name;
  final String type;
  final String available;
  final String address;
  final String cost;
}
