import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_number_dial/flutter_number_dial.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Number Dial Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var num = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Current Number : $num",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 100.0,
            ),
            RotationDialInput(
              singleNumberPadding: 10.0,
              ringWidth: 80.0,
              firstNumPosition: 3.14 / 3,
              singleNumberRadius: 30.0,
              textStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
              onNumSelected: (index) {
                print("num selected $index");

                setState(() {
                  num = num * 10 + index;
                });
              },
              animationDuration: Duration(milliseconds: 500),
            ),
          ],
        ),

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          setState(() {
            num = 0;
          });
        },
        child: Icon(Icons.restore_page_outlined),
      ),
    );
  }
}
