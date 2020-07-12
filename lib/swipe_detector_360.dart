import 'dart:math';

import 'package:flutter/widgets.dart';

enum SWIPING_TYPE {
  START,
  UPDATING,
  END,
}

/// The inputed [function] will be called by [SwipeDetector360Widget] when directed [SWIPING_TYPE] fires.
///
/// In addition, in case of [SWIPING_TYPE.END], user's swiping needs to be in defined angle range.
/// [activationDegreeFrom] and [activateTo] role degree. They must to be -180 ~ 180.
///
/// Followings are some exlample for case of [SWIPING_TYPE.END].
/// Values from 0 ~ 90, the top-left quadrant swiping.
/// Values from 90 ~ 180, the top-right quadrant swiping.
/// Values from 0 ~ -90, the bottom-left quadrant swiping.
/// Values from -90 ~ -180, the bottom-right quadrant swiping.
/// Values from 90 ~ 180 and -90 ~ -180, the right swiping.
/// Values from -90 ~ 90, the left swiping.
class SwipeDetector360Function {
  SwipeDetector360Function({
    this.activationDegreeFrom = -180,
    this.activationDegreeTo = 180,
    @required this.function,
    @required this.swipingType,
  }) {
    assert(activationDegreeFrom >= -181);
    assert(activationDegreeTo <= 181);
    assert(activationDegreeFrom <= activationDegreeTo);
    assert(function != null);
  }

  final double activationDegreeFrom;
  final double activationDegreeTo;

  /// Type of argument must be DragStartDetails, DragUpdateDetails or DragEndDetails.
  final Function(dynamic) function;
  final SWIPING_TYPE swipingType;

  /// Return if [activationDegreeFrom] degree <= inputed [degree] <= [activationDegreeTo] degree then [true] alse [false].
  bool isInActivationRnage(double degree) {
    if (swipingType != SWIPING_TYPE.END) {
      return true;
    }

    return (activationDegreeFrom <= degree && degree <= activationDegreeTo)
        ? true
        : false;
  }
}

/// This widget executes [functions] parent's widget provides when it detects particular swiping.
///
/// Ignore a just tapping if [isExceptTapping] is true, when funtions are set [SWIPING_TYPE.END].
class SwipeDetector360Widget extends StatelessWidget {
  const SwipeDetector360Widget({
    Key key,
    this.child,
    this.functions,
    this.isExceptTapping = true,
  }) : super(key: key);
  final Widget child;
  final List<SwipeDetector360Function> functions;
  final bool isExceptTapping;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: this.child,
      onPanStart: (details) {
        var targetFunctions = _retriveFunctions(SWIPING_TYPE.START).toList();

        for (var func in targetFunctions) {
          func.function(details);
        }
      },
      onPanUpdate: (details) {
        var targetFunctions = _retriveFunctions(SWIPING_TYPE.UPDATING).toList();

        for (var func in targetFunctions) {
          func.function(details);
        }
      },
      onPanEnd: (details) {
        var targetFunctions = _retriveFunctions(SWIPING_TYPE.END).toList();

        double degree =
            details.velocity.pixelsPerSecond.direction * 360 / (2 * pi);
        if (degree == 0.0 && isExceptTapping) return;

        for (var func in targetFunctions) {
          if (func.isInActivationRnage(degree)) {
            func.function(details);
          }
        }
      },
    );
  }

  Iterable<SwipeDetector360Function> _retriveFunctions(SWIPING_TYPE type) {
    return functions.where(
      (element) {
        if (element.swipingType == type) {
          return true;
        } else {
          return false;
        }
      },
    );
  }
}
