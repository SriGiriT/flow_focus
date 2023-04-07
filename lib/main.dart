import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flow_focus/utils/local_circular_countdown_timer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flow_focus/constants.dart';
import 'package:flow_focus/theme/theme_data.dart';
import 'components/button_widget.dart';
import 'components/timer_portion.dart';
import 'package:flow_focus/screens/timer_screen.dart';
import 'package:flow_focus/utils/local_circular_countdown_timer.dart';


void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FocusFlow',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: TimerScreen(controller: CountDownController(), stopWatchTimer: StopWatchTimer(), reverseController: LocalCountDownController(),),
    );
  }
}

