import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:growbdo/utils/local_circular_countdown_timer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:growbdo/constants.dart';
import '../components/button_widget.dart';

class TimerPortion extends StatefulWidget {
  TimerPortion(
      {super.key,
      required this.currentState,
      required this.controller,
      required this.stopWatchTimer,
      required this.reverseController});
  String currentState;
  CountDownController controller;
  StopWatchTimer stopWatchTimer;
  LocalCountDownController reverseController;
  StopWatchTimer reverseStopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countDown);
  bool isBreak = false;
  int breakTime = 5;
  String breakState = "NotRunning";
  @override
  State<TimerPortion> createState() => _TimerPortionState();
}

class _TimerPortionState extends State<TimerPortion> {
  @override
  Widget build(BuildContext context) {
    return widget.isBreak == true
        ? Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2 - 140,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonWidget(
                        title: widget.breakState == "NotRunning"
                            ? "Start"
                            : widget.breakState == "Running"
                                ? "Pause"
                                : "Resume",
                        colors: widget.breakState == "Paused"
                            ? [kTimerColor, kTimerColor]
                            : [Color(0xFF619113), Color(0xFF649613)],
                        onPressed: () {
                          if (widget.breakState == "NotRunning") {
                            widget.reverseController.start();
                            widget.reverseStopWatchTimer.clearPresetTime();
                            widget.reverseStopWatchTimer
                                .setPresetMinuteTime(widget.breakTime);
                            widget.reverseStopWatchTimer.onStartTimer();
                            setState(() {
                              widget.breakState = "Running";
                            });
                          } else if (widget.breakState == "Running") {
                            widget.reverseController.pause();
                            widget.reverseStopWatchTimer.onStopTimer();
                            setState(() {
                              widget.breakState = "Paused";
                            });
                          } else {
                            widget.reverseController.resume();
                            widget.reverseStopWatchTimer.onStartTimer();
                            setState(() {
                              widget.breakState = "Running";
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      buttonWidget(
                          title: "Stop",
                          colors: [Color(0xFFEF0304), Color(0xFFFF0000)],
                          onPressed: () {
                            widget.reverseController.reset();
                            widget.reverseStopWatchTimer.onResetTimer();
                            setState(() {
                              widget.breakState = "NotRunning";
                              widget.isBreak = false;
                              widget.currentState = "NotRunning";
                            });
                          }),
                    ],
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    LocalCountDownTimer(
                      duration: widget.breakTime * 60,
                      initialDuration: 0,
                      controller: widget.reverseController,
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 2,
                      ringColor: Colors.grey[300]!,
                      ringGradient: null,
                      fillColor: kBreakColor,
                      fillGradient: null,
                      backgroundColor: kBreakColor,
                      backgroundGradient: const RadialGradient(
                        radius: 0.5,
                        colors: <Color>[kBreakColor, kPrimaryLightColor],
                        stops: [0.6, 1],
                      ),
                      strokeWidth: 20.0,
                      strokeCap: StrokeCap.round,
                      textStyle: const TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textFormat: LocalCountdownTextFormat.HH_MM_SS,
                      isReverse: true,
                      isReverseAnimation: true,
                      isTimerTextShown: true,
                      autoStart: false,
                      onStart: () {
                        debugPrint('Countdown Started');
                      },
                      onComplete: () {
                        debugPrint('Countdown Ended');
                      },
                      onChange: (String timeStamp) {
                        debugPrint('Countdown Changed $timeStamp');
                      },
                      timeFormatterFunction:
                          (defaultFormatterFunction, duration) {
                        if (!widget.reverseStopWatchTimer.isRunning &&
                            (widget.breakState == "NotRunning" ||
                                widget.breakState == "Paused")) {
                          return "▶";
                        } else {
                          // widget.reverseController.reset();
                          return "Ⅱ";
                        }
                      },
                    ),
                    StreamBuilder<int>(
                      stream: widget.reverseStopWatchTimer.rawTime,
                      initialData: 0,
                      builder: (context, snap) {
                        final value = snap.data;
                        final displayTime =
                            StopWatchTimer.getDisplayTime(value!);
                        return Column(
                          children: <Widget>[
                            Text(
                              widget.reverseStopWatchTimer.isRunning ? 
                              displayTime
                                  .toString()
                                  .substring(0, displayTime.length - 3) : "Break",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2 - 140,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonWidget(
                        title: widget.currentState == "NotRunning"
                            ? "Start"
                            : widget.currentState == "Running"
                                ? "Pause"
                                : "Resume",
                        colors: widget.currentState == "Paused"
                            ? [kTimerColor, kTimerColor]
                            : [Color(0xFF619113), Color(0xFF649613)],
                        onPressed: () {
                          if (widget.currentState == "NotRunning") {
                            widget.controller.start();
                            widget.stopWatchTimer.clearPresetTime();
                            widget.stopWatchTimer.onStartTimer();
                            setState(() {
                              widget.currentState = "Running";
                            });
                          } else if (widget.currentState == "Running") {
                            widget.controller.pause();
                            widget.stopWatchTimer.onStopTimer();
                            setState(() {
                              widget.currentState = "Paused";
                            });
                          } else {
                            widget.controller.resume();
                            widget.stopWatchTimer.onStartTimer();
                            setState(() {
                              widget.currentState = "Running";
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      buttonWidget(
                        title: "Stop",
                        colors: [Color(0xFFEF0304), Color(0xFFFF0000)],
                        onPressed: () {
                          widget.controller.reset();
                          widget.stopWatchTimer.onResetTimer();
                          setState(
                            () {
                              widget.breakState = "NotRunning";
                              widget.isBreak = true;
                              widget.currentState = "NotRunning";
                              // < 25 - 5 mins < 50 - 8 mins < 90 - 15 mins > 80 20 mins
                              widget.stopWatchTimer.minuteTime.listen(
                                (value) {
                                  if (value < 25) {
                                    widget.breakTime = 5;
                                  } else if (value < 50) {
                                    widget.breakTime = 8;
                                  } else if (value < 90) {
                                    widget.breakTime = 15;
                                  } else {
                                    widget.breakTime = 20;
                                  }
                                },
                              );
                              widget.reverseStopWatchTimer.clearPresetTime();
                              widget.reverseStopWatchTimer
                                  .setPresetMinuteTime(widget.breakTime);
                            },
                          );

                        },
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    CircularCountDownTimer(
                      duration: 3600,
                      initialDuration: 0,
                      controller: widget.controller,
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 2,
                      ringColor: Colors.grey[300]!,
                      ringGradient: null,
                      fillColor: kTimerColor,
                      fillGradient: null,
                      backgroundColor: kTimerColor,
                      backgroundGradient: const RadialGradient(
                        radius: 0.5,
                        colors: <Color>[kTimerColor, kPrimaryLightColor],
                        stops: [0.6, 1],
                      ),
                      strokeWidth: 20.0,
                      strokeCap: StrokeCap.round,
                      textStyle: const TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.HH_MM_SS,
                      isReverse: false,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: false,
                      onStart: () {
                        debugPrint('Countdown Started');
                      },
                      onComplete: () {
                        debugPrint('Countdown Ended');
                      },
                      onChange: (String timeStamp) {
                        debugPrint('Countdown Changed $timeStamp');
                      },
                      timeFormatterFunction:
                          (defaultFormatterFunction, duration) {
                        if (!widget.stopWatchTimer.isRunning &&
                            (widget.currentState == "NotRunning" ||
                                widget.currentState == "Paused")) {
                          return "▶";
                        } else {
                          if (duration.inSeconds == 3600) {
                            widget.controller.restart(duration: 3600);
                          }
                          return "Ⅱ";
                        }
                      },
                    ),
                    StreamBuilder<int>(
                      stream: widget.stopWatchTimer.rawTime,
                      initialData: 0,
                      builder: (context, snap) {
                        final value = snap.data;
                        final displayTime =
                            StopWatchTimer.getDisplayTime(value!);
                        return Column(
                          children: <Widget>[
                            Text(
                              displayTime
                                  .toString()
                                  .substring(0, displayTime.length - 3),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
