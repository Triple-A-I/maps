import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Position currentPosition;
  late LocationPermission locationPermission;

  Future getPosition() async {
    bool services = false;

    services = await Geolocator.isLocationServiceEnabled();

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.always) {
        getLatLong();
      }
    }
    debugPrint("$services");
    debugPrint("$locationPermission");
  }

  Future<Position> getLatLong() async {
    print('======');
    print(await Geolocator.checkPermission());
    print('======');

    return Geolocator.getCurrentPosition(
            forceAndroidLocationManager: true,
            timeLimit: null,
            desiredAccuracy: LocationAccuracy.medium)
        .then((value) {
      return value;
    });
  }

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                double distanceBetween = Geolocator.distanceBetween(
                        15.500654, 33.000000, 24.711666, 46.724167) /
                    1000;
                print("Distance in Km is $distanceBetween");
              },
              child: Text('Distance')),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          currentPosition = await getLatLong();

          print("latitude ${currentPosition.latitude}");
          print("longitude ${currentPosition.longitude}");
        },
        child: Icon(
          Icons.location_on_outlined,
        ),
      ),
    );
  }
}
