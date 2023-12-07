import 'package:flutter/material.dart';
// import 'package:stopwatch_app/stopwatch.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var textEmail = TextEditingController();
  var textPassword = TextEditingController();
  // final _nameController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  // final _passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
        // key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Stopwatch',
                  style: TextStyle(fontSize: 36),
                ),
                const Text(
                  'Cronômetro de exercícios',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: textEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'Insira seu email.';
                    }
                    final regex = RegExp('[^@]+@[^.]+..+');
                    if (!regex.hasMatch(text)) {
                      return 'Insira um email válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: textPassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira a senha';
                    } else if (value.length <= 6) {
                      return 'A senha deve ter mais do que seis dígitos';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      style: const ButtonStyle(),
                      child: const Text('Registrar',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xff4c505b),
                              fontSize: 18)),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'forgot');
                        },
                        child: const Text(
                          'Esqueceu a senha?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xff4c505b),
                            fontSize: 18,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      LoginController()
                          .login(context, textEmail.text, textPassword.text);
                    },
                    child: const Text('Entrar')),
              ],
            )));
  }

  // void _validate() {
  //   final form = _formKey.currentState;
  //   if (form?.validate() == false) {
  //     return;
  //   }

  //   final name = _nameController.text;
  //   final email = _emailController.text;
  //   final password = _passwordControler.text;

  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (_) =>
  //           StopWatchApp(name: name, email: email, password: password),
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _emailController.dispose();
  //   _passwordControler.dispose();
  //   super.dispose();
  // }
}
