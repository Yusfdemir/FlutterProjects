import 'package:flutter/material.dart';
import 'dart:math';

// rollDice fonksiyonu içinde kullansaydık her çağrı yapıldığında yeni bir random nesnesi oluşacaktı ama bize bir tane oluşması yeter ondan dolayı dışarıya aldık
final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 1;

  void rollDice() {
    setState(() {
      currentDiceRoll = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(
        "lib/assets/images/dice-$currentDiceRoll.png",
        width: 200,
      ),
      // padding yerine alternatif olarak kullanılabilir
      const SizedBox(
        height: 20,
      ),
      TextButton(
        onPressed: rollDice,
        style: TextButton.styleFrom(
          // padding: const EdgeInsets.only(top: 20),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 28),
        ),
        child: const Text("Zar At"),
      ),
    ]);
  }
}
