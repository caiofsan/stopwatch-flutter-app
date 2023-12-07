// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import '../controller/login_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var textName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Row(
      //     children: [
      //       Expanded(
      //           child: Text(
      //         'Editar perfil',
      //         style: TextStyle(color: Colors.white),
      //       )),
      //     ],
      //   ),
      //   backgroundColor: Colors.grey,
      // ),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.28,
              left: 35,
              right: 35,
            )),

            // TÍTULO DA TELA
            Text(
              'Editar perfil',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20.0),

            Text(
              'Insira um novo nome',
              style: TextStyle(fontSize: 20),
            ),
            FutureBuilder(
                future: LoginController().loggedUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text('Nome atual: ${snapshot.data.toString()}');
                  }
                  return Text('');
                }),
            const SizedBox(height: 30.0),

            // CAMPO 'NOME'
            TextField(
              controller: textName,
              decoration: InputDecoration(
                  labelText: 'Nome',
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            const SizedBox(height: 30.0),

            //LINHA PARA OS BOTÕES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // BOTÃO 'SALVAR'
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blueAccent.shade400),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    LoginController().editUserName(context, textName.text);
                  },
                  child: const Text('Salvar'),
                ),
                SizedBox(
                  width: 30.0,
                ),

                // BOTÃO 'CANCELAR'
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
