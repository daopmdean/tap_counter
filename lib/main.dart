import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tap Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    int? count = prefs.getInt('counter');
    if (count != null) {
      setState(() {
        _counter = count;
      });
    }
  }

  void _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter + 1);
    setState(() {
      _counter++;
    });
  }

  void _decreaseCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter - 1);
    setState(() {
      _counter--;
    });
  }

  void _restartCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', 0);
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _incrementCounter,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Tapped count:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: _decreaseCounter,
              tooltip: 'Decrease',
              child: const Icon(Icons.exposure_minus_1),
            ),
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              onPressed: _restartCounter,
              tooltip: 'Restart',
              child: const Icon(Icons.restart_alt_outlined),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
