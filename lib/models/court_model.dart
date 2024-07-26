class CourtModel {
  const CourtModel({
    required this.id,
    required this.name,
    required this.type,
    required this.available,
    required this.address,
    required this.cost,
  });

  final int id;
  final String name;
  final String type;
  final String available;
  final String address;
  final String cost;
}
