import 'package:flutter/material.dart';
import 'price_screen.dart';
void main()=>runApp(BitcoinTricker());

class BitcoinTricker extends StatelessWidget {
  const BitcoinTricker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white
      ),
      home: PriceScreen(),
    );
  }
}

