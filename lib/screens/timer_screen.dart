import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:growbdo/components/button_widget.dart';
import 'package:growbdo/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:growbdo/utils/local_circular_countdown_timer.dart';
import 'package:growbdo/components/timer_portion.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen(
      {Key? key,
      required this.controller,
      required this.stopWatchTimer,
      required this.reverseController})
      : super(key: key);

  final CountDownController controller;
  final StopWatchTimer stopWatchTimer;
  final LocalCountDownController reverseController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title: const Text(
          "FLOWFOCUS",
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.notifications),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TimerPortion(
              currentState: "NotRunning",
              controller: controller,
              stopWatchTimer: stopWatchTimer,
              reverseController: reverseController,
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              elevation: 30,
              shadowColor: Colors.black,
              color: Colors.black12,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: RadialGradient(
                                  colors: [Colors.white, kTaskContainerColor],
                                  stops: [0.4, 1])),
                          child: Icon(
                            Icons.play_circle_filled_rounded,
                            color: kTimerColor,
                            size: 45,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "TASKS",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                    buttonWidget(title: "Add Task", colors: [
                      Color(0xFF696969),
                      Color(0xFF686868),
                      Color(0xFF3E3E3E)
                    ], width: 300)
                  ],
                ),
                decoration: BoxDecoration(
                  color: kTaskContainerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
