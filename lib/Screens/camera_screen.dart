import 'package:btp_app/Screens/camera_screen.dart';
import 'package:btp_app/main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
// import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController cameraController;
  late CameraImage imgCamera;

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/mobilenet_v1_1.0_224.tflite",
        labels: "assets/mobilenet_v1_1.0_224.txt");
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  initCamera() {
    loadModel();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );

    cameraController.initialize().then((value) {
      if (mounted) {
        setState(() {
          cameraController.startImageStream((imageFromStream) {
            imgCamera = imageFromStream;
            runModelOnStreamFrames();
          });
        });
      }
    });
  }

  runModelOnStreamFrames() async {
    var recognitions = await Tflite.runModelOnFrame(
      bytesList: imgCamera.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: imgCamera.height,
      imageWidth: imgCamera.width,
      numResults: 3,
      threshold: 0.2,
    );

    var result = "";

    recognitions?.forEach((response) {
      result +=
          response["label"] + (response["confidence"] as double).toString();
      print(result);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Camera Screen'),
        ),
        body: Container(child: CameraPreview(cameraController)));
  }
}
