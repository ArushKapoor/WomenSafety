import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AudioRecordPage extends StatefulWidget {
  static const String id = 'audio_record_page';
  @override
  _AudioRecordPageState createState() => _AudioRecordPageState();
}

class _AudioRecordPageState extends State<AudioRecordPage> {
  static const platform = const MethodChannel('com.women_safety/audio');
  void record() async {
    String value;

    try {
      value = await platform.invokeMethod('record');
    } catch (e) {
      print(e);
    }

    print(value);
  }

  void play() async {
    String value;

    try {
      value = await platform.invokeMethod('play');
    } catch (e) {
      print(e);
    }

    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Record Audio'),
            FlatButton(
              onPressed: record,
              child: Text('RECORD'),
            ),
            FlatButton(
              onPressed: null,
              child: Text('STOP'),
            ),
            Text('PLAY'),
            FlatButton(
              onPressed: play,
              child: Text('PLAY RECORDED FILE'),
            ),
            FlatButton(
              onPressed: null,
              child: Text('STOP RECORDED FILE'),
            ),
          ],
        ),
      ),
    );
  }
}
