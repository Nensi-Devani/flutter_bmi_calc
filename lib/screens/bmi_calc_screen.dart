import 'package:bmi_calc/screens/result_screen.dart';
import 'package:flutter/material.dart';

class BmiCalcScreen extends StatefulWidget {
  const BmiCalcScreen({super.key});

  @override
  State<BmiCalcScreen> createState() => _BmiCalcScreenState();
}

class _BmiCalcScreenState extends State<BmiCalcScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double result = 0;
  String message = '';
  bool isValidated = false;
  List<Color> colors = [
    Color(0xffd32f2e),
    Color(0xfff55f2e),
    Color(0xfff55f2e),
  ];

  late Color selColor;
  @override
  void initState() {
    super.initState();
    selColor = colors[0];
  }

  void validate() {
    if (weightController.text.isNotEmpty && heightController.text.isNotEmpty) {
      isValidated = true;
    } else {
      isValidated = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calc'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // inputs fields
            TextField(
              controller: weightController,
              onChanged: (v) {
                validate();
              },
              decoration: InputDecoration(
                labelText: "Weight",
                hint: Text('Enter your Weight in KGs'),
              ),
            ),
            SizedBox(height: 10), // for space between inputs
            TextField(
              controller: heightController,
              onChanged: (v) {
                validate();
              },
              decoration: InputDecoration(
                labelText: "Height",
                hint: Text('Enter your Height in Meters'),
              ),
            ),
            SizedBox(height: 10),
            // button
            ElevatedButton(
              onPressed: isValidated
                  ? () {
                      double wt = double.parse(weightController.text);
                      double ht = double.parse(heightController.text);
                      result = wt / (ht * ht);
                      Navigator.push( // pass data to result_screen
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(result),
                        ),
                      );
                      if (result < 16) {
                        message = 'Severe Thinness';
                        selColor = colors[0];
                      } else if (result < 17) {
                        message = 'Moderate Thinness';
                        selColor = colors[1];
                      } else if (result < 18.5) {
                        message = 'Mild Thinness';
                        selColor = colors[2];
                      } else if (result < 25) {
                        message = 'Normal';
                        selColor = colors[3];
                      } else if (result < 30) {
                        message = 'Overweight';
                        selColor = colors[4];
                      } else if (result < 35) {
                        message = 'Obese Class 1';
                        selColor = colors[5];
                      } else if (result < 40) {
                        message = 'Obese Class 2';
                        selColor = colors[6];
                      } else {
                        message = 'Obese Class 3';
                        selColor = colors[7];
                      }
                      setState(() {});
                    }
                  : null, // null = disable the btn
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            // print result
            Text(
              'Result : ${result.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              '$message',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                // color: Color(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
