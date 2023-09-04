import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flow_focus/components/button_widget.dart';
import 'package:flow_focus/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flow_focus/utils/local_circular_countdown_timer.dart';
import 'package:flow_focus/components/timer_portion.dart';
import 'package:flow_focus/data/task_data.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryLightColor,
            title: Text(
              "FLOWFOCUS",
              style: GoogleFonts.publicSans(),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.notifications),
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ),
            ]

            // [
            //   Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 8.0),
            //     child: Icon(Icons.notifications),
            //   ),
            //   Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 8.0),
            //     child: IconButton(
            //       icon: Icon(Icons.menu),
            //       onPressed: () {
            //         Scaffold.of(context).openDrawer();
            //       },
            //     ),
            //   )
            // ],
            ),
        endDrawer: Drawer(
          backgroundColor: kPrimaryLightColor,
          elevation: 0,
          semanticLabel: 'Minimal Drawer',
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                height: 80,
                decoration: BoxDecoration(color: kPrimaryLightColor),
                child: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 30,color: Colors.white,
                    ),
                    onPressed: () {
                      Scaffold.of(context).closeEndDrawer();
                    },
                  ),
                ),
              ),
              // add the options for the drawer
              ListTile(
                title: Text(
                  'Login',
                  style: drawerText,
                ),
                onTap: () {
                  // navigate to the login screen
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
              ),
              ListTile(
                title: Text(
                  'Status',
                  style: drawerText,
                ),
                onTap: () {
                  // navigate to the settings screen
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              ListTile(
                title: Text(
                  'Settings',
                  style: drawerText,
                ),
                onTap: () {
                  // navigate to the profile screen
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
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
                child: Expanded(
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
                                  gradient: RadialGradient(colors: [
                                Colors.white,
                                kTaskContainerColor
                              ], stops: [
                                0.4,
                                1
                              ])),
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
                              style: GoogleFonts.publicSans().copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                          // Set the width and height of the container
                          width: 300,
                          height: 170,
                          // Add some padding around the container
                          // Add a ListView widget inside the container
                          margin: EdgeInsets.all(14),
                          child: ListView.builder(
                            itemCount: taskList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFF373737),
                                    ),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF373737),
                                      Color(0x00373737)
                                    ])),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Text(
                                        taskList[index]["title"],
                                        style: GoogleFonts.publicSans()
                                            .copyWith(
                                                fontSize: 20,
                                                color: Color(0xFFC7C1CC),
                                                fontWeight: FontWeight.bold),
                                        // style: TextStyle(fontSize : 20, color: Color(0xFFC7C1CC), fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Time taken _${taskList[index]["time_spend"]}_",
                                        style:
                                            GoogleFonts.publicSans().copyWith(
                                          fontSize: 16,
                                          color: Color(0xFF6A6C73),
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                              );
                            },
                          ),
                        ),
                        buttonWidget(
                            textColor: Colors.white,
                            title: "Add Task",
                            onHoverColor: [
                              Color(0xFF696969),
                              Color(0xFF686868),
                              Color(0xFF3E3E3E)
                            ],
                            colors: [
                              Color(0xFF696969),
                              Color(0xFF686868),
                              Color(0xFF3E3E3E)
                            ],
                            width: 180)
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: kTaskContainerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
