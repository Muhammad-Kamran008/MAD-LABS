import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Counter extends InheritedWidget {
  final int count;
  final VoidCallback increment;
  final VoidCallback decrement;

  const Counter({
    Key? key,
    required this.count,
    required this.increment,
    required this.decrement,
    required Widget child,
  }) : super(key: key, child: child);

  static Counter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Counter>();
  }

  @override
  bool updateShouldNotify(Counter oldWidget) {
    return count != oldWidget.count;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CounterProvider(),
    );
  }
}

class CounterProvider extends StatefulWidget {
  const CounterProvider({Key? key}) : super(key: key);

  @override
  CounterProviderState createState() => CounterProviderState();
}

class CounterProviderState extends State<CounterProvider> {
  int count = 0;

  void _incrementCounter() {
    if (count < 10) {
      setState(() {
        count++;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: const Text('You cannot increment more!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _decrementCounter() {
    if (count > 1) {
      setState(() {
        count--;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: const Text('You cannot decrement more!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Counter(
      count: count,
      increment: _incrementCounter,
      decrement: _decrementCounter,
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            centerTitle: true,
          ),
          floatingActionButton:
              ExtraIncrementButton(increment: _incrementCounter),
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You have pushed the button $count times",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '$count',
                      style: const TextStyle(fontSize: 60.0),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: count > 0 ? _decrementCounter : null,
                          child: const Text(
                            '-',
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: count < 10 ? _incrementCounter : null,
                          child: const Text(
                            '+',
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExtraIncrementButton extends StatelessWidget {
  final VoidCallback increment;

  const ExtraIncrementButton({Key? key, required this.increment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0.0,
      bottom: 0.0,
      child: FloatingActionButton(
        onPressed: increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

