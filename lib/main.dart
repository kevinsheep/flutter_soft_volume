import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _volumeValue = 0;
  bool _showSystemUI = VolumeController().showSystemUI;

  @override
  void initState() {
    super.initState();

    // Listen to system volume change
    VolumeController().listener((volume) {
      setState(() => _volumeValue = volume);
    });
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('音量控制'),
            actions: [
              const Text('系统UI', style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.0,
                  height: 3,
              )),
              Switch(
                value: _showSystemUI,
                activeColor: Colors.cyanAccent,
                inactiveThumbColor: Colors.lightBlueAccent,
                onChanged: (value) {
                  _showSystemUI = value;
                  setState(() => VolumeController().showSystemUI = value);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Slider(
                        label: '${_volumeValue * 100 ~/ 1}%',
                        divisions: 100,
                        value: _volumeValue,
                        min: 0,
                        max: 1,
                        onChanged: (value) =>
                            VolumeController().setVolume(value),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () => VolumeController().muteVolume(),
                      label: const Text(''),
                      icon: const Icon(Icons.volume_off_rounded),
                    ),
                    TextButton.icon(
                      onPressed: () => VolumeController().maxVolume(),
                      label: const Text(''),
                      icon: const Icon(Icons.volume_up_rounded),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
