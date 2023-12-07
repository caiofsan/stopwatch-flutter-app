
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/record_model.dart';
import '../view/messages.dart';
import 'login_controller.dart';

class RecordController {
  final _db = FirebaseFirestore.instance;

  // ADICIONAR NOVO REGISTRO
  void addRecord(context, Record r) {
    _db
        .collection('records')
        .add(r.toJson())
        .then((value) => success(context, 'Registro salvo'))
        .catchError(
            (e) => error(context, 'Ocorreu um problema ao salvar o registro'))
        .whenComplete(() => Navigator.pop(context));
  }

  // EXCLUIR REGISTRO
  void deleteRecord(context, id) {
    _db
        .collection('records')
        .doc(id)
        .delete()
        .then((value) => success(context, 'Registro excluído'))
        .catchError((e) =>
            error(context, 'Ocorreu um problema ao tentar excluir o registro'));
  }

  // LISTAR O HISTÓRICO DE REGISTROS
  listAllRecords() {
    return _db
        .collection('records')
        .where('uid', isEqualTo: LoginController().userID());
  }
}
