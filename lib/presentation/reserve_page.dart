import 'package:carousel_slider/carousel_slider.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tennis_app/core/utils.dart';
import 'package:tennis_app/core/widgets/btn_icon_tennis.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';

class ReservePage extends StatefulWidget {
  const ReservePage({super.key});

  static String routeName = 'reserve';

  @override
  State<ReservePage> createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _initHourController = TextEditingController();
  final _endHourController = TextEditingController();
  final _textController = TextEditingController();
  DateTime? _selectedDate;
  DateTime? _selectedFirstTime;

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
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: [
                  Image.asset(
                    'assets/images/authenticated_background.png',
                    width: double.infinity,
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
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Epic Box',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Cancha tipo A',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'Disponible',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.watch_later_outlined,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                '9:00 pm a 10:00 pm',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                'New York',
                                style: TextStyle(fontSize: 12),
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
                          r'$25',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Por hora',
                          style: TextStyle(fontSize: 12, color: Colors.black38),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.cloud_queue_rounded, size: 16),
                            SizedBox(width: 5),
                            Text('30%'),
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
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.all(5),
                    isExpanded: true,
                    value: 'd',
                    underline: const Offstage(),
                    items: const [
                      DropdownMenuItem(
                        value: 'd',
                        child: Text('data'),
                      ),
                      DropdownMenuItem(
                        value: 'a',
                        child: Text('data'),
                      ),
                      DropdownMenuItem(
                        value: 'dat',
                        child: Text('data'),
                      ),
                    ],
                    onChanged: (value) {},
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
