import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(HangmanGame());
}

class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  final List<String> words = ["FLUTTER", "MOBILE", "HANGMAN", "DART", "WIDGET"];
  late String wordToGuess;
  late Set<String> guessedLetters;
  int wrongGuesses = 0;
  final int maxWrongGuesses = 6;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    setState(() {
      wordToGuess = words[Random().nextInt(words.length)];
      guessedLetters = {};
      wrongGuesses = 0;
    });
  }

  String displayWord() {
    return wordToGuess.split('').map((letter) {
      return guessedLetters.contains(letter) ? letter : "_";
    }).join(" ");
  }

  void guessLetter(String letter) {
    setState(() {
      if (!wordToGuess.contains(letter)) {
        wrongGuesses++;
      }
      guessedLetters.add(letter);
    });
  }

  bool isGameOver() => wrongGuesses >= maxWrongGuesses || isGameWon();
  bool isGameWon() => wordToGuess.split('').every((letter) => guessedLetters.contains(letter));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple.shade200, Colors.blue.shade200], // Lavender to Soft Blue
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hangman Game",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 10, color: Colors.black45, offset: Offset(3, 3))],
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Wrong Guesses: $wrongGuesses / $maxWrongGuesses",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amberAccent),
                ),
                SizedBox(height: 20),
                Text(
                  displayWord(),
                  style: TextStyle(
                    fontSize: 40,
                    letterSpacing: 4,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    shadows: [Shadow(blurRadius: 10, color: Colors.black45, offset: Offset(2, 2))],
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("").map((letter) {
                    return ElevatedButton(
                      onPressed: isGameOver() || guessedLetters.contains(letter) ? null : () => guessLetter(letter),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: guessedLetters.contains(letter) ? Colors.grey : Colors.purple.shade300,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.all(12),
                        shadowColor: Colors.black45,
                        elevation: 5,
                      ),
                      child: Text(
                        letter,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                if (isGameOver())
                  Text(
                    isGameWon() ? "🎉 You WON! 🎉" : "💀 You LOST! 💀",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                  ),
                if (isGameOver()) SizedBox(height: 10),
                if (isGameOver())
                  ElevatedButton(
                    onPressed: startNewGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent.shade400, // **Updated to Purple**
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                    ),
                    child: Text(
                      "Play Again",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
