import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_detector_360/swipe_detector_360.dart';

class WidgetSample4SwipeDetector360 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WidgetSample4SwipeDetector360Status();
}

class _WidgetSample4SwipeDetector360Status
    extends State<WidgetSample4SwipeDetector360> {
  final _streamController = StreamController<List<String>>();

  @override
  Widget build(BuildContext context) {
    final funcs = _SwipeDetector360FunctionsSample(_streamController.sink);

    return SwipeDetector360Widget(
      functions: funcs.sampleFunctions,
      isExceptTapping: false,
      child: StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue[100],
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(snapshot.hasData ? snapshot.data[0] : 'swipe'),
                ),
                Center(
                  child: Text(snapshot.hasData ? snapshot.data[1] : 'here!'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

class _SwipeDetector360FunctionsSample {
  _SwipeDetector360FunctionsSample(this.sink) {
    _generate();
  }

  final StreamSink sink;
  final sampleFunctions = List<SwipeDetector360Function>();

  bool _generate() {
    sampleFunctions.add(
      SwipeDetector360Function(
        function: (d) {
          List<String> s = _detectedInformation(d, 'swipe starts : ');
          sink.add(s);
        },
        swipingType: SWIPING_TYPE.START,
      ),
    );

    sampleFunctions.add(
      SwipeDetector360Function(
        function: (d) {
          List<String> s = _detectedInformation(d, 'swipe doing : ');
          sink.add(s);
        },
        swipingType: SWIPING_TYPE.UPDATING,
      ),
    );

    sampleFunctions.add(
      SwipeDetector360Function(
        function: (d) {
          List<String> s = _detectedInformation(d, 'swipe to Bottom-right : ');
          sink.add(s);
        },
        activationFrom: -0.1,
        activationTo: 90.1,
        swipingType: SWIPING_TYPE.END,
      ),
    );

    sampleFunctions.add(
      SwipeDetector360Function(
        function: (d) {
          List<String> s = _detectedInformation(d, 'swipe to Bottom-left : ');
          sink.add(s);
        },
        activationFrom: 89.9,
        activationTo: 180.1,
        swipingType: SWIPING_TYPE.END,
      ),
    );

    sampleFunctions.add(
      SwipeDetector360Function(
        function: (d) {
          List<String> s = _detectedInformation(d, 'swipe to Top-right : ');
          sink.add(s);
        },
        activationFrom: -90.1,
        activationTo: 0.1,
        swipingType: SWIPING_TYPE.END,
      ),
    );

    sampleFunctions.add(
      SwipeDetector360Function(
        function: (d) {
          List<String> s = _detectedInformation(d, 'swipe to Top-left : ');
          sink.add(s);
        },
        activationFrom: -180.1,
        activationTo: -89.9,
        swipingType: SWIPING_TYPE.END,
      ),
    );

    return true;
  }

  List<String> _detectedInformation<T>(T d, String prefix) {
    final strings = List<String>();

    if (d is DragStartDetails) {
      final DragStartDetails dd = d;
      strings.add(prefix);
      strings.add(dd.globalPosition.toString());
    } else if (d is DragUpdateDetails) {
      final DragUpdateDetails dd = d;
      strings.add(prefix);
      strings.add(dd.globalPosition.toString());
    } else if (d is DragEndDetails) {
      final DragEndDetails dd = d;
      strings.add(prefix);
      strings.add(dd.velocity.pixelsPerSecond.toString() +
          ' --> degree : ' +
          (dd.velocity.pixelsPerSecond.direction * 360 / 2 / pi).toString());
    } else {
      strings.add('Some bugs are living in the code.');
      strings.add('Need to fix.');
    }

    return strings;
  }
}
