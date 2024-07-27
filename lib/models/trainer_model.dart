class TrainerModel {
  const TrainerModel({required this.id, required this.name});

  factory TrainerModel.fromMap(Map<String, dynamic> json) {
    return TrainerModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
    );
  }

  factory TrainerModel.toTest() => const TrainerModel(id: '00', name: 'Test');

  final String id;
  final String name;
}
