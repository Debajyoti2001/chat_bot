import 'package:chatbot/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimated = false;
  @override
  void initState() {
    super.initState();
    startAnimate();
  }

  Future<void> startAnimate() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      isAnimated = true;
    });
    await Future.delayed(const Duration(milliseconds: 5000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              top: isAnimated ? 200: -30,
              left: isAnimated ? 50: -30,
              duration: const Duration(milliseconds: 2000),
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(20))),
              )),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              top: isAnimated ? 50 : -30,
              right: isAnimated ? 50 : -30,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(50))),
              )),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              top: MediaQuery.of(context).size.height / 3,
              left: isAnimated ? MediaQuery.of(context).size.width / 3 : 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Explore',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blueAccent.withOpacity(0.8))),
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/195.jpg'),
                  ),
                ],
              )),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              bottom: isAnimated ? 200 : -30,
              right: isAnimated ? 50 : -30,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(20))),
              )),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              bottom: isAnimated ? 100 : -30,
              left: isAnimated ? 50 : -30,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(50))),
              )),
        ],
      ),
    );
  }
}
