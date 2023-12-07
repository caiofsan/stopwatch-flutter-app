
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch_app/stopwatch.dart';
import '../view/messages.dart';

class LoginController {
  final _db = FirebaseFirestore.instance;
  // CRIAR CONTA
  createAccount(context, name, email, password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
      // O nome do usuário é armazenado no Firestore
      _db
          .collection('users')
          .add({'uid': response.user!.uid, 'name': name, 'email': email});

      // MENSAGEM DE CONFIRMAÇÃO (USUÁRIO CADASTRADO COM SUCESSO)
      success(context, 'Usuário cadastrado!');
      Navigator.pop(context);
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          error(context, 'Já existe um usuário com esse E-mail.');
          break;
        case 'invalid-email':
          error(context, 'E-mail inválido.');
          break;
        default:
          error(context, 'Ocorreu um erro: ${e.code.toString()}');
      }
    });
  }

  // LOGIN
  login(context, email, password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
      success(context, 'Login realizado.');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => StopWatchApp(email: email, password: password)));
    }).catchError((e) {
      switch (e.code) {
        case 'user-not-found':
          error(context, 'Usuário não encontrado.');
          break;
        case 'invalid-login-credentials':
          error(context, 'E-mail e/ou senha incorreta.');
          break;
        case 'invalid-email':
          error(context, 'Por favor, insira um E-mail válido.');
          break;
        case 'missing-password':
          error(context, 'Por favor, insira a senha.');
          break;
        default:
          error(context, 'Ocorreu um erro: ${e.code.toString()}');
      }
    });
  }

  // ESQUECEU A SENHA
  forgotPasswd(context, String email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      success(context, 'E-mail enviado. Verifique a sua caixa de entrada.');
      Navigator.pop(context);
    } else {
      error(context, 'Não foi possível enviar o E-mail.');
    }
  }

  // LOGOUT
  logout() {
    FirebaseAuth.instance.signOut();
  }

  //
  // MANIPULAÇÃO DE DADOS
  //
  // EDITAR NOME
  void editUserName(context, name) {
    _db
        .collection('users')
        .doc(userID())
        .update(name.toJson())
        .then((value) => success(context, 'Perfil atualizado!'))
        .catchError(
            (e) => error(context, 'Não foi possível atualizar o perfil.'))
        .whenComplete(() => Navigator.pop(context));
  }

  // User ID
  userID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  // User Name
  Future<String> loggedUserName() async {
    var user = '';
    await _db
        .collection('users')
        .where('uid', isEqualTo: userID())
        .get()
        .then((result) {
      user = result.docs[0].data()['name'] ?? '';
    });
    return user;
  }

  Future<String> loggedUserEmail() async {
    var user = '';
    await _db
        .collection('users')
        .where('uid', isEqualTo: userID())
        .get()
        .then((result) {
      user = result.docs[0].data()['email'] ?? '';
    });
    return user;
  }
}
