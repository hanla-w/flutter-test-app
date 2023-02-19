import 'package:flutter/material.dart';

int getOddOneOut({required List<int> array}) {
  bool isEvenArray = false;
  int evenCount = 0;
  for (int i in array) {
    if (i.isEven) {
      evenCount++;
    }
    if (evenCount > 1) {
      isEvenArray = true;
      break;
    }
  }
  int oddOneOut = array
      .firstWhere((element) => isEvenArray ? element.isOdd : element.isEven);
  return oddOneOut;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Odd One Out',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Znajdź niepasującą liczbę'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(title))),
      body: const Center(
        child: MyFormPage(),
      ),
    );
  }
}

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _handlePressButton() {
    List<String> strarray = myController.text.split(",");
    List<int> array = strarray.map((e) => int.parse(e)).toList();
    String oddOneOut = getOddOneOut(array: array).toString();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Center(
              child: Text(oddOneOut,
                  style: const TextStyle(
                      fontSize: 72, fontWeight: FontWeight.bold))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Wpisz numery',
              ),
              controller: myController),
        ),
        FilledButton(
            onPressed: _handlePressButton, child: const Text("Wyszukaj"))
      ],
    );
  }
}
