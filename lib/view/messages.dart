import 'package:flutter/material.dart';

// MENSAGEM DE SUCESSO
void success(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg, style: const TextStyle(color: Colors.white)),
    backgroundColor: Colors.green.shade600,
    duration: const Duration(seconds: 3),
  ));
}

// MENSAGEM DE ERRO
void error(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg, style: const TextStyle(color: Colors.white)),
    backgroundColor: Colors.orangeAccent.shade700,
    duration: const Duration(seconds: 3),
  ));
}
