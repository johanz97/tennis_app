import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/widgets/btn_icon_tennis.dart';
import 'package:tennis_app/core/widgets/weather_info.dart';
import 'package:tennis_app/logic/trainer_provider.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/presentation/reserve/widgets/reserve_body.dart';
import 'package:tennis_app/presentation/reserve/widgets/summary_body.dart';

import 'package:tennis_app/services/local_service.dart';

enum ReserveEnum { reserve, summary }

class ReservePage extends StatelessWidget {
  const ReservePage({required this.court, super.key});

  static String routeName = 'reserve';

  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return TrainerProvider(service: LocalService());
      },
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
  ReserveEnum _selectedIndex = ReserveEnum.reserve;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
                      fit: BoxFit.fill,
                    )
                  else
                    Image.asset(
                      'assets/images/logo_login.png',
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                ],
                options: CarouselOptions(
                  height: height * 0.35,
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
                        WeatherInfo(city: widget.court.address),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          if (_selectedIndex == ReserveEnum.reserve)
            ReserveBody(
              onContinue: () {
                setState(() => _selectedIndex = ReserveEnum.summary);
              },
            )
          else
            SummaryBody(
              onChangeState: () {
                setState(() => _selectedIndex = ReserveEnum.reserve);
              },
            ),
        ],
      ),
    );
  }
}
