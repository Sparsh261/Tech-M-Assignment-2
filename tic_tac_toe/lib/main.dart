
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 129, 211),
          centerTitle: true,
          title: Text(
            'TIC TAC TOE GME',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30),
                PlayerPanel(),
                SizedBox(width: 350, child:GameGrid()),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class PlayerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Card(
        color: Color.fromARGB(255, 28, 129, 211),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PlayerNamePanel('Sparsh', 'X'),
            // Text(
            //   'TIC TAC TOE',
            //   style: TextStyle(
            //     fontSize: 22,
            //     color: Color.fromARGB(255, 255, 255, 255),
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            PlayerNamePanel('Raj', 'O'),
          ],
        ),
      ),
    );
  }
}


class PlayerNamePanel extends StatefulWidget {
  String initialName = "";
  String initialSymbol = "";

  PlayerNamePanel(String name, String symbol) {
    initialName = name;
    initialSymbol = symbol;
  }
  @override
  State<PlayerNamePanel> createState() {
    return PlayerNamePanelState();
  }
}

class PlayerNamePanelState extends State<PlayerNamePanel> {
  String playerName = "PlayerA";
  String buttonText = "edit";
  String playerSymbol = "X";

  @override
  initState() {
    super.initState();
    playerName = widget.initialName;
    playerSymbol = widget.initialSymbol;
  }

  TextEditingController textController = TextEditingController();

  onEditName() {
    setState(() {
      if (buttonText == 'edit') {
        buttonText = 'save';
        textController.text = playerName;
      } else {
        playerName = textController.text;
        buttonText = 'edit';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: 130,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color.fromARGB(255, 28, 129, 211),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buttonText == "edit"
                ? Text(
                  playerName,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                )
                : TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    border: OutlineInputBorder(),
                  ),
                ),
            Text(
              playerSymbol,
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 131, 192, 242),
              ),
              onPressed: onEditName,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameGrid extends StatefulWidget {
  @override
  State<GameGrid> createState() {
    return GameGridState();
  }
}

class GameGridState extends State<GameGrid> {
  List<String> gameState = ["", "", "", "", "", "", "", "", "", ""];
  //                            1   2   3   4   5   6   7   8    9

  String turnSymbol = 'X';
  String turnText = "Turn:X";
  String result = "";

  onGameGridButtonClick(int index) {
    if(result == "WIN") return;
    else{
    setState(() {
      
      if (gameState[index] == "") {
        gameState[index] = turnSymbol;
      }

      result = checkWin();
      if (result == 'WIN') {
        turnText = "WIN:" + turnSymbol;
      } else if (result == "DRAW") {
        turnText = "DRAW";
      } else {
        turnSymbol = turnSymbol == 'X' ? 'O' : 'X';
        turnText = "Turn:" + turnSymbol;
      }
    });
    }
  }

  String checkWin() {   

    List<List<int>> winCombinations = [
    [1, 2, 3], // horizontal
    [4, 5, 6], // horizontal
    [7, 8, 9], // horizontal
    [1, 4, 7], // vertical
    [2, 5, 8], // vertical
    [3, 6, 9], // vertical
    [1, 5, 9], // diagonal
    [3, 5, 7], // diagonal
  ];

  for (var combination in winCombinations) {
    if (gameState[combination[0]] == turnSymbol &&
        gameState[combination[1]] == turnSymbol &&
        gameState[combination[2]] == turnSymbol) {
          setState(() {
          gameState[combination[0]] += " ";
          gameState[combination[1]] += " ";
          gameState[combination[2]] += " ";
          });
      return "WIN";
    }
  }

    for (int i = 1; i <= 9; i++) {
      if (gameState[i] == "") {
        return 'GAMEON';
      }
    }
    return "DRAW";
  }

  void restart(){
    setState(() {
      gameState = ["", "", "", "", "", "", "", "", "", ""];
      turnSymbol = 'X';
      turnText = "Turn:X";
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 125),
                Text(
                  turnText,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 28, 129, 211),
                  ),
                ),
              ],
            ),
            Row(children: [buildButton(1), buildButton(2), buildButton(3)]),
            Row(children: [buildButton(4), buildButton(5), buildButton(6)]),
            Row(children: [buildButton(7), buildButton(8), buildButton(9)]),
            SizedBox(height: 30),
            result == "WIN" || result == "DRAW"?
            ElevatedButton(
                child: Text("Restart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20)),
                onPressed: (){restart();},
                style: ElevatedButton.styleFrom(
                  iconSize: 20,
                  backgroundColor: Colors.red
                ),
              )
            :Text(""),

          ],
        ),
      ),
    );
  }

  Widget buildButton(int index) {
    Color color = gameState[index] == turnSymbol+" " ? Colors.red : Colors.blue ;
    return Container(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 100,
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: (){
            onGameGridButtonClick(index);
            },
          child: Text(
            gameState[index],
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}