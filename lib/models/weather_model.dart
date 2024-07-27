class WeatherModel {
  const WeatherModel({
    required this.tempC,
    required this.tempF,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> json) => WeatherModel(
        tempC: double.parse(json['temp_c']?.toString() ?? '.0'),
        tempF: double.parse(json['temp_f']?.toString() ?? '.0'),
      );

  factory WeatherModel.toSet() => const WeatherModel(tempC: 0, tempF: 0);

  final double tempC;
  final double tempF;
}
