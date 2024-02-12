import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_task/controller/weather_controller.dart';
import 'package:weather_task/view/widgets/myListTile.dart';


class WeatherDetailsScreen extends StatelessWidget {
  final WeatherController _weatherController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final weatherData = _weatherController.weatherData;
    final double temperature = weatherData['main']['temp'].toDouble();
    final double celsiusTemperature = temperature - 273.15;
    final String backgroundImage =
        _weatherController.getBackgroundImage(celsiusTemperature);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(96, 0, 0, 0),
        title: const Text(
          'Weather Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(
          () {
            final weatherData = _weatherController.weatherData;
            final double temperature = weatherData['main']['temp'].toDouble();
            final double celsiusTemperature = temperature - 273.15;
            final int temp = celsiusTemperature.toInt();

            if (weatherData == null || weatherData.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Container(
              child: ListView(
                children: [
                  MyListTile(
                    title: 'Temperature:',
                    subtitle: '$temp°C',
                  ),
                  MyListTile(
                    title: 'Weather Condition:',
                    subtitle: '${weatherData['weather'][0]['main']}',
                  ),
                  MyListTile(
                    title: 'Humidity:',
                    subtitle: '${weatherData['main']['humidity']}%',
                  ),
                  MyListTile(
                    title: 'Wind Speed:',
                    subtitle: '${weatherData['wind']['speed']} M/S',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
