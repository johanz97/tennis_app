import 'package:carousel_slider/carousel_slider.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/utils.dart';
import 'package:tennis_app/core/widgets/btn_icon_tennis.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/logic/trainer_provider.dart';
import 'package:tennis_app/logic/weather_provider.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/models/trainer_model.dart';
import 'package:tennis_app/services/local_service.dart';
import 'package:tennis_app/services/weather_service.dart';

class ReservePage extends StatelessWidget {
  const ReservePage({required this.court, super.key});

  static String routeName = 'reserve';

  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return TrainerProvider(service: LocalService());
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return WeatherProvider(service: WeatherService(Dio()));
          },
        ),
      ],
      child: _ReservePageWidget(court: court),
    );
  }
}

class _ReservePageWidget extends StatefulWidget {
  const _ReservePageWidget({required this.court});

  final CourtModel court;

  @override
  State<_ReservePageWidget> createState() => _ReservePageWidgetState();
}

class _ReservePageWidgetState extends State<_ReservePageWidget> {
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

  Future<void> _getWeather() async {
    final response = await context.read<WeatherProvider>().getWeather(
          widget.court.address,
        );
    response.fold((errorMessage) {}, (_) {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTrainers();
      _getWeather();
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
    final isLoading = context.watch<WeatherProvider>().isLoading;
    final weather = context.watch<WeatherProvider>().weather;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: [
                  if (widget.court.image.isNotEmpty)
                    Image.network(
                      widget.court.image,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.fill,
                    )
                  else
                    Image.asset(
                      'assets/images/logo_login.png',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                ],
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BtnIconTennis(
                        icon: Icons.arrow_back,
                        onTap: context.pop,
                      ),
                      const Icon(
                        Icons.favorite_border,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.court.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Cancha tipo ${widget.court.type}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text(
                                'Disponible',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.watch_later_outlined,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                widget.court.available,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                widget.court.address,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${widget.court.cost}',
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Por hora',
                          style: TextStyle(fontSize: 12, color: Colors.black38),
                        ),
                        const SizedBox(height: 5),
                        if (isLoading)
                          const CircularProgressIndicator()
                        else
                          Row(
                            children: [
                              Icon(
                                (weather?.tempC ?? 0) > 30
                                    ? Icons.cloudy_snowing
                                    : Icons.cloud_queue_rounded,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              Text('${weather?.tempC ?? 0}°C'),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
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
              ],
            ),
          ),
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
                      format: DateFormat("yyyy-MM-dd"),
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
                            format: DateFormat("HH:mm"),
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
                            format: DateFormat("HH:mm"),
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
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
