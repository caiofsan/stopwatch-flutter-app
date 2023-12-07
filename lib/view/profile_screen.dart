// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:stopwatch_app/view/editprofile_screen.dart';
import 'package:stopwatch_app/view/history_screen.dart';
import '../controller/login_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: Text(
              'Perfil',
              style: TextStyle(color: Colors.white),
            )),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            FutureBuilder(
                future: LoginController().loggedUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text('Perfil de ${snapshot.data.toString()}',
                        style: TextStyle(fontSize: 32));
                  }
                  return Text('');
                }),
            const SizedBox(height: 30.0),
            // COLUNA 'NOME'
            Column(
              children: [
                Text(
                  'Nome',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                    future: LoginController().loggedUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(fontSize: 18),
                        );
                      }
                      return Text('');
                    })
              ],
            ),
            const SizedBox(height: 30.0),

            // COLUNA 'E-MAIL'
            Column(
              children: [
                Text(
                  'E-Mail',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                    future: LoginController().loggedUserEmail(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(fontSize: 18),
                        );
                      }
                      return Text('');
                    })
              ],
            ),
            const SizedBox(height: 30.0),

            //LINHA PARA OS BOTÕES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // BOTÃO 'EDITAR'
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blueAccent.shade400),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    _openEditProfile(context: context);
                  },
                  child: const Text('Editar'),
                ),
                SizedBox(
                  width: 30.0,
                ),
                // BOTÃO 'HISTÓRICO DE EXERCÍCIOS'
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blueAccent.shade400),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    _openHistory(context: context);
                  },
                  child: const Text('Histórico'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Abrir 'Editar Perfil'
  void _openEditProfile({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );
  }

  // Abrir Histórico
  void _openHistory({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryScreen(),
      ),
    );
  }
}
