import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// don't forget "with SingleTickerProviderStateMixin"
class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {

        });
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('oOKiTo'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateY(pi * _animation.value),
              child: GestureDetector(
                onTap: (){
                  if (_status == AnimationStatus.dismissed) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
                child: Card(
                  child: _animation.value <= 0.5
                      ? Container(
                      color: Colors.blue,
                      width: 240,
                      height: 300,
                      child: const Center(
                          child: Text(
                            '?',
                            style: TextStyle(fontSize: 100, color: Colors.white),
                          )))
                      : Container(
                      width: 240,
                      height: 300,
                      color: Colors.grey,
                      child: Image.network(
                        'https://www.dbestech.com/img/mobile.png',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}