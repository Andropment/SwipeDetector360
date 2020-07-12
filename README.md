# swipe_detector_360

A widget fires function with particular swiping angle.

## Demo

You can learn how working this widget by adding WidgetSample4SwipeDetector360() in your code.

```dart
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DEMO'),),
      body: WidgetSample4SwipeDetector360(),
    );
  }
}
```

![SwipeDetector360demo1](https://user-images.githubusercontent.com/14831422/87248086-69f2a380-c492-11ea-91be-98d1c91c7562.gif)

## Getting Started

Basically, the widget wraps GestureDetecter and extend the "onPan..." callbacks.

1) Create variables of SwipeDetector360Function.

```dart
// This will be fired when SwipeDetector360Widget detects a swiping to top-right.
// The type of argument "d" is DragEndDetail when SWIPING_TYPE is END.
// "SWIPING_TYPE.END" means this will be fired when called onPanEnd() internally.
// "activationDegreeFrom: -90" and "activationDegreeTo: 0" means swiping angle to top-right.
final function1 = SwipeDetector360Function(
        function: (d) {
          // something you want to do.
        },
        swipingType: SWIPING_TYPE.END,
        activationDegreeFrom: -90,
        activationDegreeTo: 0,
      );

// This will be fired when SwipeDetector360Widget detects a swiping to bottom-right.
// The type of argument "d" is DragEndDetail when SWIPING_TYPE is END.
// "SWIPING_TYPE.END" means this will be fired when called onPanEnd() internally.
// "activationDegreeFrom: 90" and "activationDegreeTo: 180" means swiping angle to bottom-right.
final function2 = SwipeDetector360Function(
        function: (d) {
          // something you want to do.
        },
        swipingType: SWIPING_TYPE.END,
        activationDegreeFrom: 90,
        activationDegreeTo: 180,
      );
```

2) Add variables to list and add the list to SwipeDetector360Widget.

```dart
final functions = List<SwipeDetector360Function>();
functions.add(function1);
functions.add(function2);

@override
  Widget build(BuildContext context) {

    return SwipeDetector360Widget(
      functions: functions,
      child:
    ),
  }
```