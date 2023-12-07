import 'package:flutter/material.dart';

void main() {
  runApp(const EncourageScreen());
}
class EncourageScreen extends StatelessWidget {
    const EncourageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Você consegue!!'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('“Lembre-se de que a sensação que você tem de uma boa corrida é muito melhor do que a sensação de ficar sentado desejando estar correndo.” Sarah Condor'),
          ),
      ),
    );
  }
}
