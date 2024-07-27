import 'package:hive/hive.dart';
import 'package:tennis_app/models/court_model.dart';

class CourtModelAdapter extends TypeAdapter<CourtModel> {
  @override
  final typeId = 1;

  @override
  CourtModel read(BinaryReader reader) {
    final data = reader.read();
    return CourtModel.fromMap(
      Map<String, dynamic>.from(data as Map<dynamic, dynamic>),
    );
  }

  @override
  void write(BinaryWriter writer, CourtModel obj) {
    writer.write(obj.toMap());
  }
}
