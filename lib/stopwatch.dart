// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stopwatch_app/controller/record_controller.dart';
import 'package:stopwatch_app/model/record_model.dart';
import 'package:stopwatch_app/view/encourage_screen.dart';
import 'package:stopwatch_app/view/history_screen.dart';
import 'package:stopwatch_app/view/profile_screen.dart';
import 'view/platform_alert.dart';
import 'view/about_screen.dart';
import 'controller/login_controller.dart';

class StopWatchApp extends StatefulWidget {
  static const route = '/stopwatch';
  final String email;
  final String password;

  const StopWatchApp({super.key, required this.email, required this.password});

  @override
  State<StopWatchApp> createState() => _StopWatchAppState();
}

class _StopWatchAppState extends State<StopWatchApp> {
  bool isTicking = false;
  int milliseconds = 0;
  late Timer timer;
  DateTime? tstp;
  final laps = <int>[];
  final itemHeight = 60.0;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer time) {
    if (mounted) {
      setState(() {
        milliseconds += 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: Text(
              'Stopwatch',
              style: TextStyle(color: Colors.white),
            )),
            FutureBuilder<String>(
                future: LoginController().loggedUserName(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 14)),
                          onPressed: () {
                            LoginController().logout();
                            Navigator.pushReplacementNamed(context, 'login');
                          },
                          icon: Icon(Icons.exit_to_app, size: 18),
                          label: Text(snapshot.data.toString()),
                        ));
                  }
                  return Text('');
                }))
          ],
        ),
        backgroundColor: Colors.grey,
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.info_outline),
        //     onPressed: () => _openPageAbout(
        //       context: context,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildCounter(context)),
          Expanded(child: _buildLapDisplay()),
        ],
      ),

      // Menu "Hamburguer"
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.grey),
                child: Text(
                  'Stopwatch',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            ListTile(
              title: const Text('Página Inicial'),
              // selected: ,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Perfil'),
              // selected: ,
              onTap: () {
                _openProfile(context: context);
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Histórico'),
              // selected: ,
              onTap: () {
                _openHistory(context: context);
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sobre o App'),
              // selected: ,
              onTap: () {
                _openPageAbout(context: context);
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // Botão de incentivo (frase motivacional)
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEncourage(context: context),
        tooltip: 'Incentivo',
        child: const Icon(Icons.sentiment_satisfied_alt),
      ),
    );
  }

  //
  // MÉTODOS DE REDIRECIONAMENTO
  //

  // Abrir Perfil
  void _openProfile({required BuildContext context}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()));
  }

  // Abrir 'Sobre o App'
  void _openPageAbout({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AboutScreen(),
      ),
    );
  }

  // Abrir Incentivo
  void _openEncourage({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EncourageScreen(),
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

  Widget _buildCounter(BuildContext context) {
    return Container(
        color: Colors.blueAccent.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lap ${laps.length + 1}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            ),
            Text(
              _secondsText(milliseconds),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildControls()
          ],
        ));
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: isTicking ? null : _startTimer,
          child: const Text('Iniciar'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
          ),
          onPressed: isTicking ? _lap : null,
          child: const Text('Volta'),
        ),
        const SizedBox(width: 20),
        Builder(builder: (context) {
          return TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: isTicking ? () => _stopTimer(context) : null,
            child: const Text('Terminar'),
          );
        }),
      ],
    );
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
    tstp = DateTime.now();

    setState(() {
      milliseconds = 0;
      laps.clear();
      isTicking = true;
    });
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds segundos';
  }

  void _stopTimer(BuildContext context) {
    timer.cancel();
    setState(() {
      isTicking = false;
    });
    final totalRunTime = laps.fold(milliseconds, (total, lap) => total + lap);
    final alert = PlatformAlert(
      title: 'Volta Completa',
      message: 'tempo total da volta é ${_secondsText(totalRunTime)}.',
    );
    alert.show(context);

    var r = Record(LoginController().userID(), totalRunTime.toDouble(),
        laps.length + 1, tstp);

    RecordController().addRecord(context, r);

    showBottomSheet(context: context, builder: _buildRunCompleteSheet);
    final controller =
        showBottomSheet(context: context, builder: _buildRunCompleteSheet);

    Future.delayed(const Duration(seconds: 5)).then((_) {
      controller.close();
    });
  }

  Widget _buildRunCompleteSheet(BuildContext context) {
    final totalRuntime = laps.fold(milliseconds, (total, lap) => total + lap);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Container(
      color: Theme.of(context).cardColor,
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Corrida finalizada!', style: textTheme.titleLarge),
            Text('Tempo total de Corrida é ${_secondsText(totalRuntime)}.')
          ])),
    ));
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
      child: ListView.builder(
          controller: scrollController,
          itemExtent: itemHeight,
          itemCount: laps.length,
          itemBuilder: (context, index) {
            final milliseconds = laps[index];
            return ListTile(
              title: Text(_secondsText(milliseconds)),
            );
          }),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    scrollController.dispose();
    super.dispose();
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });

    scrollController.animateTo(itemHeight * laps.length,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}
