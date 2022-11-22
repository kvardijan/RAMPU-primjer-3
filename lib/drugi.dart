import 'package:flutter/material.dart';

class DrugiEkran extends StatelessWidget {
  const DrugiEkran({Key? key, required this.payload}) : super(key: key);

  final String payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ovo je drugi ekran"),
      ),
      body: Center(
        child: Text(
          payload,
        ),
      ),
    );
  }
}
