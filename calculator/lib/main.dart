import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final t1Controller = TextEditingController();
  final t2Controller = TextEditingController();
  final resultController = TextEditingController();

  String t1 = "";
  String t2 = "";
  String result = "";
  String op = "";
  int num1 = -1;
  int num2 = -1;

  Widget btn(String value) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        onPressed: () => btnClicked(value),
        child: Text(
          value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void btnClicked(String value) {
    if (value == "c") {
      num1 = 0;
      num2 = 0;
      t1 = "";
      t2 = "";
      op = "";
      t1Controller.clear();
      t2Controller.clear();
      resultController.clear();
    } else if (value == "+" ||
        value == "-" ||
        value == "*" ||
        value == "/" ||
        value == "%") {
      op = value;
    } else if (value == '=') {
      if (t1Controller.text == "" || t2Controller.text == "") {
        resultController.text = "0";
      } else {
        num1 = int.parse(t1Controller.text);
        num2 = int.parse(t2Controller.text);
        if (op == "/" && num2 == 0)
          resultController.text = "Can't divide with 0";
        else {
          switch (op) {
            case "+":
              resultController.text = (num1 + num2).toString();
            case "-":
              resultController.text = (num1 - num2).toString();
            case "*":
              resultController.text = (num1 * num2).toString();
            case "/":
              resultController.text = (num1 / num2).toString();
            case "%":
              resultController.text = (num1 % num2).toString();
          }
        }
      }
    } else {
      setState(() {
        if (op == "") {
          t1Controller.text += value;
        } else {
          t2Controller.text += value;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator App",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50, bottom: 50, left: 30, right: 30),

        color: const Color.fromARGB(255, 74, 75, 75),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 400,
            // height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: TextField(
                    readOnly: true,
                    controller: t1Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'num 1',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    readOnly: true,
                    controller: t2Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'num 2',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    readOnly: true,
                    controller: resultController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'result',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [btn("1"), btn("2"), btn("3"), btn("=")],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [btn("4"), btn("5"), btn("6"), btn("+")],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [btn("7"), btn("8"), btn("9"), btn("-")],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [btn("0"), btn("%"), btn("/"), btn("*")],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [btn("c")],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
