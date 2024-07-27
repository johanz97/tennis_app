class WeatherModel {
  const WeatherModel({
    required this.tempC,
    required this.precipitation,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> json) => WeatherModel(
        tempC: double.parse(json['temp_c']?.toString() ?? '.0'),
        precipitation: double.parse(json['precip_mm']?.toString() ?? '.0'),
      );

  factory WeatherModel.toSet() =>
      const WeatherModel(tempC: 0, precipitation: 0);

  final double tempC;
  final double precipitation;
}
