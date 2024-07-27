import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tennis_app/firebase_options.dart';
import 'package:tennis_app/presentation/my_app.dart';
import 'package:tennis_app/services/adapters/booking_model_adapter.dart';
import 'package:tennis_app/services/adapters/court_model_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(BookingModelAdapter())
    ..registerAdapter(CourtModelAdapter());

  runApp(const MyApp());
}
