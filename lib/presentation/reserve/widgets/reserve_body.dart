import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/utils.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/logic/trainer_provider.dart';
import 'package:tennis_app/models/trainer_model.dart';

class ReserveBody extends StatefulWidget {
  const ReserveBody({required this.onContinue, super.key});

  final VoidCallback onContinue;

  @override
  State<ReserveBody> createState() => _ReserveBodyState();
}

class _ReserveBodyState extends State<ReserveBody> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _initHourController = TextEditingController();
  final _endHourController = TextEditingController();
  final _textController = TextEditingController();
  DateTime? _selectedDate;
  DateTime? _selectedFirstTime;

  Future<void> _getTrainers() async {
    final response = await context.read<TrainerProvider>().getTrainers();
    response.fold((errorMessage) {}, (_) {});
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
    final selectedTrainer = context.watch<TrainerProvider>().selectedTrainer;

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
              context.read<TrainerProvider>().selectedTrainer = value;
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
                    onChanged: (value) => setState(
                      () => _selectedDate = value,
                    ),
                    validator: (value) {
                      if (value == null) return 'Ingrese una fecha';

                      return null;
                    },
                    onShowPicker: (context, currentValue) async {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
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
                          onChanged: (value) => setState(
                            () => _selectedFirstTime = value,
                          ),
                          validator: (value) {
                            if (value == null) return 'Ingrese una hora';

                            return null;
                          },
                          onShowPicker: (context, currentValue) async {
                            if (_selectedDate == null) return null;
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now(),
                              ),
                            );
                            return DateTimeField.combine(
                              _selectedDate!,
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
                          validator: (value) {
                            if (value == null) return 'Ingrese una hora';

                            return null;
                          },
                          onShowPicker: (context, currentValue) async {
                            if (_selectedFirstTime == null) return null;
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                _selectedFirstTime!,
                              ),
                            );
                            return DateTimeField.combine(
                              _selectedDate!,
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
