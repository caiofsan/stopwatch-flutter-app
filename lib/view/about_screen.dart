// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(const AboutScreen());
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: Text(
              'Sobre o Aplicativo',
              style: TextStyle(color: Colors.white),
            )),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'O aplicativo é um exemplo do trabalho desenvolvido pelos alunos da disciplina de Programação de Dispositivos Móveis, ministrada pelo professor Rodrigo de Oliveira Plotze.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 12.0),
                Text(
                  'Stopwatch é um aplicativo que ajuda você a acompanhar seus exercícios físicos usando um cronômetro. Todos os tempos de seus exercícios são armazenados em seu perfil pessoal.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20.0),

                // COLUNA COM INFORMAÇÕES SOBRE OS DESENVOLVEDORES
                Column(
                  children: [
                    Text(
                      'Desenvolvedores',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15.0),

                    // LINHA COM AS IMAGENS DOS DESENVOLVEDORES
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            // COLUNA COM IMAGEM E DESCRIÇÃO
                            child: Column(
                          children: <Widget>[
                            Image.asset('../assets/caio.png'),
                            Text('Caio Felipe dos Santos')
                          ],
                        )),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                            // COLUNA COM IMAGEM E DESCRIÇÃO
                            child: Column(
                          children: <Widget>[
                            Image.asset('../assets/cezio.png'),
                            Text('Cezio Ferreira')
                          ],
                        )),
                      ],
                    )
                  ],
                ),

                
              ],
            )),
      ),
    );
  }
}
