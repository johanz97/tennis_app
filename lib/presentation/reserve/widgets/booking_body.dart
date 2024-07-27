import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/utils.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/logic/summary_provider.dart';
import 'package:tennis_app/logic/trainer_provider.dart';
import 'package:tennis_app/models/trainer_model.dart';
import 'package:tennis_app/services/local_service.dart';

class BookingBody extends StatelessWidget {
  const BookingBody({required this.onContinue, super.key});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return TrainerProvider(service: LocalService());
      },
      child: _BookingBodyWidget(onContinue: onContinue),
    );
  }
}

class _BookingBodyWidget extends StatefulWidget {
  const _BookingBodyWidget({required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<_BookingBodyWidget> createState() => _BookingBodyWidgetState();
}

class _BookingBodyWidgetState extends State<_BookingBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _initHourController = TextEditingController();
  final _endHourController = TextEditingController();
  final _textController = TextEditingController();

  Future<void> _getTrainers() async {
    final trainerProvider = context.read<TrainerProvider>();
    final response = await trainerProvider.getTrainers();
    response.fold((errorMessage) {}, (_) {
      if (trainerProvider.trainers.isNotEmpty) {
        context.read<SummaryProvider>().selectedTrainer =
            trainerProvider.trainers.first;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTrainers();
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _initHourController.dispose();
    _endHourController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trainers = context.watch<TrainerProvider>().trainers;
    final selectedTrainer = context.watch<SummaryProvider>().selectedTrainer;
    final selectedDate = context.watch<SummaryProvider>().selectedDate;
    final selectedFirstTime =
        context.watch<SummaryProvider>().selectedFirstTime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: 160,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<TrainerModel>(
            padding: const EdgeInsets.all(5),
            isExpanded: true,
            value: selectedTrainer,
            underline: const Offstage(),
            items: List<DropdownMenuItem<TrainerModel>>.from(
              trainers.map(
                (trainer) {
                  return DropdownMenuItem(
                    value: trainer,
                    child: Text(trainer.name),
                  );
                },
              ).toList(),
            ),
            onChanged: (value) {
              context.read<SummaryProvider>().selectedTrainer = value;
            },
          ),
        ),
        const SizedBox(height: 20),
        SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blueGrey[50],
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Establecer fecha y hora',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DateTimeField(
                    controller: _dateController,
                    format: DateFormat('yyyy-MM-dd'),
                    decoration: decorationDate(
                      context: context,
                      label: 'Fecha',
                    ),
                    onChanged: (value) {
                      context.read<SummaryProvider>().selectedDate = value;
                    },
                    validator: (value) {
                      if (value == null) return 'Ingrese una fecha';

                      return null;
                    },
                    onShowPicker: (context, currentValue) async {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: DateTimeField(
                          controller: _initHourController,
                          format: DateFormat('HH:mm'),
                          decoration: decorationDate(
                            context: context,
                            label: 'Hora inicio',
                          ),
                          onChanged: (value) {
                            context.read<SummaryProvider>().selectedFirstTime =
                                value;
                          },
                          validator: (value) {
                            if (value == null) return 'Ingrese una hora';

                            return null;
                          },
                          onShowPicker: (context, currentValue) async {
                            if (selectedDate == null) return null;

                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now(),
                              ),
                            );
                            return DateTimeField.combine(
                              selectedDate,
                              time,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: DateTimeField(
                          controller: _endHourController,
                          format: DateFormat('HH:mm'),
                          decoration: decorationDate(
                            context: context,
                            label: 'Hora fin',
                          ),
                          onChanged: (value) {
                            context.read<SummaryProvider>().selectedLastTime =
                                value;
                          },
                          validator: (value) {
                            if (value == null) return 'Ingrese una hora';

                            return null;
                          },
                          onShowPicker: (context, currentValue) async {
                            if (selectedFirstTime == null) return null;
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                selectedFirstTime,
                              ),
                            );
                            return DateTimeField.combine(
                              selectedDate!,
                              time,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Agregar un comentario',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _textController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      counter: const Offstage(),
                      hintText: 'Agrega un comentario...',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BtnTennis(
                    text: 'Reservar',
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (!_formKey.currentState!.validate()) return;

                      widget.onContinue();
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
