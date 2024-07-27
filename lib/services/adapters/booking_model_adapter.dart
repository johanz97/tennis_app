import 'package:hive/hive.dart';
import 'package:tennis_app/models/booking_model.dart';

class BookingModelAdapter extends TypeAdapter<BookingModel> {
  @override
  final typeId = 0;

  @override
  BookingModel read(BinaryReader reader) {
    final data = reader.read();
    return BookingModel.fromMap(
      Map<String, dynamic>.from(data as Map<dynamic, dynamic>),
    );
  }

  @override
  void write(BinaryWriter writer, BookingModel obj) {
    writer.write(obj.toMap());
  }
}
