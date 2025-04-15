import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Die Klasse 'MyApp' ist ein stateless Widget und definiert das Hauptlayout der App.
class MyApp extends StatelessWidget {
  // Konstruktor 'MyApp'. Das 'super.key' vereinfacht das Widget-Schlüssel-Management.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Erstellt eine MaterialApp als Basis der App
    return MaterialApp(
      title: 'BMI-Calculator',
      theme: ThemeData(
        // Farbschema der App
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 92, 138, 74),
        ),
      ),
      // Startseite der App
      home: const MyHomePage(title: 'BMI-Calculator'),
    );
  }
}

// MyHomePage ist ein StatefulWidget / dynamich aktualisierbar
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title; // schreibt den Titel der Seite.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// privates _MyHomePageState erweitert MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  double? _bmi;
  String _bmiCategory = '';
  Color _bmiColor = Colors.black;

  //  Eingabefelder
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  // Berechnung des BMI
  void _BMI() {
    double height = double.tryParse(_height.text) ?? 0;
    double weight = double.tryParse(_weight.text) ?? 0;

    if (height > 0 && weight > 0) {
      setState(() {
        // BMI-Berechnung Gewicht / Größe^2
        _bmi = weight / ((height / 100) * (height / 100));
        _BmiKat();
      });
    }
  }

  // Festlegung der BMI-Kategorie
  void _BmiKat() {
    if (_bmi! < 18.5) {
      _bmiCategory = 'Untergewicht';
      _bmiColor = Colors.blue;
    } else if (_bmi! >= 18.5 && _bmi! < 25) {
      _bmiCategory = 'Normalgewicht';
      _bmiColor = Colors.green;
    } else if (_bmi! >= 25 && _bmi! < 30) {
      _bmiCategory = 'Übergewicht';
      _bmiColor = Colors.orange;
    } else if (_bmi! >= 30 && _bmi! < 35) {
      _bmiCategory = 'Adipositas Grad I';
      _bmiColor = Colors.red;
    } else if (_bmi! >= 35 && _bmi! < 40) {
      _bmiCategory = 'Adipositas Grad II';
      _bmiColor = Colors.redAccent;
    } else {
      _bmiCategory = 'Adipositas Grad III';
      _bmiColor = Colors.deepOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Hintergrundfarbe der App-Leiste nach Hauptschema
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // Benutzeroberfläche.
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Abstand um den Inhalt

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BMI Calculator', // Titel Testfeld
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Abstand hinzu
            const Text(
              'Height (cm)',
              style: TextStyle(fontSize: 18),
            ), // Textfeld für die Eingabe
            TextField(
              controller: _height,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.number, // Eingabe nur für Zahlen.
            ),
            const SizedBox(height: 20),
            const Text(
              'Weight (kg)',
              style: TextStyle(fontSize: 18),
            ), // Textfeld für die Eingabe des Gewichts.
            TextField(
              controller: _weight,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Button
            ElevatedButton(onPressed: _BMI, child: const Text('Calculate BMI')),
            const SizedBox(height: 20),
            if (_bmi != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Zeigt den berechneten BMI
                  Text(
                    'Your BMI is ${_bmi!.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 24, color: _bmiColor),
                  ),
                  const SizedBox(height: 10),
                  // Zeigt BMI-Kategorie an
                  Text(
                    _bmiCategory,
                    style: TextStyle(fontSize: 20, color: _bmiColor),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
