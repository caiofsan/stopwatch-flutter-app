// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch_app/controller/record_controller.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var textRuntime = TextEditingController();
  var textLaps = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                  child: Text(
                'Histórico',
                style: TextStyle(color: Colors.white),
              )),
            ],
          ),
          backgroundColor: Colors.grey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: RecordController().listAllRecords().snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                        child: Column(
                      children: [
                        Icon(Icons.cloud_off),
                        SizedBox(height: 15),
                        Text(
                          'Erro ao conectar',
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ));
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    final data = snapshot.requireData;
                    if (data.size < 1) {
                      return Center(
                          child: Column(
                        children: [
                          Icon(Icons.inbox),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Nenhum registro encontrado',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text('Que tal começar a se exercitar agora?')
                        ],
                      ));
                    } else {
                      return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          String id = data.docs[index].id;
                          dynamic item = data.docs[index].data();
                          double rtime = item['runtime'] / 1000;
                          Timestamp timestp = item['timestp'];

                          return Card(
                              child: ListTile(
                            leading: Icon(Icons.run_circle_outlined),
                            title: Text(timestp.toDate().toString()),
                            subtitle: Row(
                              children: [
                                // TEMPO DE EXERCÍCIO
                                Icon(Icons.watch_later_outlined),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Tempo: ${rtime.toString()} seg'),

                                SizedBox(
                                  width: 15.0,
                                ),

                                // VOLTAS
                                Icon(Icons.refresh),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Voltas: ${item['laps'].toString()}'),
                              ],
                            ),
                            onLongPress: () =>
                                RecordController().deleteRecord(context, id),
                          ));
                        },
                      );
                    }
                }
              }),
        ));
  }
}
