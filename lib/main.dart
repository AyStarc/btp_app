import 'package:btp_app/Screens/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'dart:math';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No Arms!',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay for the splash screen (e.g., 3 seconds)
    Future.delayed(Duration(seconds: 1), () {
      // Navigate to the home page after the delay
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlareActor(
          'Assets/Images/Game of Drones.gif', // Replace with the actual path to your GIF file
          animation: 'play', // Specify the animation to play
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Arms!'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('Assets/Images/ips.jpg'))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraScreen())
                  );
                },
                child: const Text('Open Camera'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Perform random action
                },
                child: const Text('Source Video'),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
