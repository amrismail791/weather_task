import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather_task/controller/weather_controller.dart';
import 'package:weather_task/view/Weather_details.dart';

class HomeScreen extends StatelessWidget {
  final WeatherController _weatherController =
      Get.put(WeatherController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(96, 0, 0, 0),
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Obx(() {
        final weatherData = _weatherController.weatherData;
        if (weatherData.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final double temperature = weatherData['main']['temp'].toDouble();
          final double celsiusTemperature = temperature - 273.15;
          final int temp = celsiusTemperature.toInt();
          print(celsiusTemperature);
          final String backgroundImage =
              _weatherController.getBackgroundImage(celsiusTemperature);

          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' ${temp.toString().length >= 2 ? temp.toString().substring(0, 2) : temp}°C',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    weatherData['weather'][0]['description'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => WeatherDetailsScreen());
                    },
                    child: const Text('See more info'),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
