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
    return await Geolocator.getCurrentPosition(
            timeLimit: null, desiredAccuracy: LocationAccuracy.medium)
        .then((value) => value);
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
          children: [
            ElevatedButton(
                onPressed: () async {
                  print("AAAAAALLLLLLLLBRRRRa");
                  currentPosition = await getLatLong();
                  // setState(() {});

                  print("latitude ${currentPosition.latitude}");
                  print("long ${currentPosition.longitude}");
                },
                child: const Icon(Icons.place))
          ],
        )));
  }
}
