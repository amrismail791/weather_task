import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:location/location.dart';

class WeatherController extends GetxController {
  final Dio _dio = Dio();
  final Location _location = Location();

  final RxBool isLocationLoading = false.obs;
  final RxBool isLocationAvailable = false.obs;

  final RxDouble latitude = RxDouble(0.0);
  final RxDouble longitude = RxDouble(0.0);

  final RxMap<dynamic, dynamic> weatherData = {}.obs;

  void onInit() async {
    await getCurrentLocation();
    await getWeather();

    super.onInit();
  }

  Future<void> getCurrentLocation() async {
    try {
      print(1);
      isLocationLoading(true);
      final location = await _location.getLocation();
      print(location);
      if (location != null) {
        latitude(location.latitude!);

        longitude(location.longitude!);

        isLocationAvailable(true);
      } else {
        isLocationAvailable(false);
      }
    } catch (e) {
      isLocationAvailable(false);
    } finally {
      isLocationLoading(false);
    }
  }

  Future<void> getWeather() async {
    try {
      if (isLocationAvailable.value) {
        final response = await _dio.get(
          'https://api.openweathermap.org/data/2.5/weather?lat=${latitude.value}&lon=${longitude.value}&appid=c473846d4ffd1797632c8b1ef59ca55b',
        );
        weatherData(response.data);
      } else {
        print('error');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String getBackgroundImage(double temperature) {
    
    if (temperature >= 40) {
      return 'assets/images/hot.jpg';
    } else if (temperature >= 30) {
      return 'assets/images/warm.png';
    } else if (temperature >= 20) {
      return 'assets/images/mild.jpg';
    } else {
      return 'assets/images/cold.jpeg';
    }
  }
}
