import 'package:fir_simple/userPanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
}

class AR extends StatefulWidget {
  String image_3d_path;
  AR({
   @required this.image_3d_path,
});
  @override
  _ARState createState() => _ARState();
}

class _ARState extends State<AR> {
  Object object;
  CameraController controller;


  @override
  void initState() {
    main();
    object = Object(
      fileName: widget.image_3d_path,
      lighting: true,
      visiable: true,
    );
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 10,
            toolbarHeight: 50.0,
            leadingWidth: 100,
            leading: Image(image: AssetImage('images/logo.png'),
              color: Colors.white,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
            ),
            title: Center(child: Text(
              'Details', style: TextStyle(color: Colors.white),)),
          ),
          backgroundColor: Colors.black87,
          body: !controller.value.isInitialized
              ? Container()
              : Stack(

            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 9/16,
                child: CameraPreview(controller),
              ),
              Cube(
                  onSceneCreated: (Scene scene) {
                    scene.world.add(object);
                    scene.camera.zoom = 10;
                  }),

            ],
          )),
    );
  }
}