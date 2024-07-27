import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/widgets/btn_icon_tennis.dart';
import 'package:tennis_app/core/widgets/weather_info.dart';
import 'package:tennis_app/logic/bookings_provider.dart';
import 'package:tennis_app/logic/favorite_provider.dart';
import 'package:tennis_app/logic/summary_provider.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/presentation/booking/widgets/booking_body.dart';
import 'package:tennis_app/presentation/booking/widgets/summary_body.dart';

enum BookingEnum { reserve, summary }

class BookingArg {
  const BookingArg({
    required this.court,
    required this.bookingsProvider,
    required this.favoriteProvider,
  });

  final CourtModel court;
  final BookingsProvider bookingsProvider;
  final FavoriteProvider favoriteProvider;
}

class BookingPage extends StatelessWidget {
  const BookingPage({required this.arg, super.key});

  static String routeName = 'reserve';

  final BookingArg arg;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SummaryProvider(court: arg.court),
        ),
        ChangeNotifierProvider.value(value: arg.bookingsProvider),
        ChangeNotifierProvider.value(value: arg.favoriteProvider),
      ],
      child: const _BookingPageWidget(),
    );
  }
}

class _BookingPageWidget extends StatefulWidget {
  const _BookingPageWidget();

  @override
  State<_BookingPageWidget> createState() => _BookingPageWidgetState();
}

class _BookingPageWidgetState extends State<_BookingPageWidget> {
  BookingEnum _selectedIndex = BookingEnum.reserve;

  Future<void> _onTapFavorite() async {
    final favoriteProvider = context.read<FavoriteProvider>();
    final court = context.read<SummaryProvider>().court;
    final response = favoriteProvider.isFavorite(court.id)
        ? await favoriteProvider.deleteFavorite(
            court: court,
          )
        : await favoriteProvider.addFavorite(court);
    unawaited(favoriteProvider.getFavorites());
    response.fold(
      (errorMessage) {},
      (unit) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final court = context.select<SummaryProvider, CourtModel>(
      (provider) => provider.court,
    );
    final isFavorite = context.select<FavoriteProvider, bool>(
      (provider) => provider.isFavorite(court.id),
    );

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: [
                  if (court.image.isNotEmpty)
                    Image.network(
                      court.image,
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
                      BtnIconTennis(icon: Icons.arrow_back, onTap: context.pop),
                      IconButton(
                        onPressed: _onTapFavorite,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 30,
                          color: isFavorite ? Colors.red : Colors.white,
                        ),
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
                            court.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Cancha tipo ${court.type}',
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
                              const Icon(Icons.watch_later_outlined, size: 12),
                              const SizedBox(width: 2),
                              Text(
                                court.available,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 12),
                              const SizedBox(width: 2),
                              Text(
                                court.address,
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
                          '\$${court.cost}',
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
                        WeatherInfo(city: court.address),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          if (_selectedIndex == BookingEnum.reserve)
            BookingBody(
              onContinue: () {
                setState(() => _selectedIndex = BookingEnum.summary);
              },
            )
          else
            SummaryBody(
              courtType: court.type,
              onChangeState: () {
                context.read<SummaryProvider>().clearData();
                setState(() => _selectedIndex = BookingEnum.reserve);
              },
            ),
        ],
      ),
    );
  }
}
