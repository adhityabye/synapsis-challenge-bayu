import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_challenge/src/login/domain/entities/user_data.dart';
import 'package:synapsis_challenge/src/login/presentation/widget/email_widget.dart';
import 'package:synapsis_challenge/src/login/presentation/widget/password_widget.dart';
import 'package:synapsis_challenge/src/survey/presentation/view/survey.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  // ignore: unused_field
  bool _rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final _nikController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadRememberMe();
  }

  Future<void> loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('remember_me') ?? false;
      if (_rememberMe) {
        _nikController.text = prefs.getString('nik') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> saveRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = true;
      prefs.setBool('remember_me', _rememberMe);
      prefs.setString('nik', _nikController.text);
      prefs.setString('password', _passwordController.text);
    });
  }

  Future<void> loginFunc() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('https://dev-api-lms.apps-madhani.com/v1/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nik': _nikController.text,
            'password': _passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body)['data'];
          final userData = UserData.fromJson(data);

          // ignore: use_build_context_synchronously
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Yeay login berhasil'),
                content: const Text('Selamat datang di Synapsis!'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SurveyQue()),
          );
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Hello, ${userData.name} maap aplikasinya belom jadi T_T'),
            behavior: SnackBarBehavior.floating,
          ));
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Ada yang salah sama credentials kamu nih!'),
            behavior: SnackBarBehavior.floating,
          ));
        }
      } catch (e) {
        print('Login failed: $e');
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Login to Synapsis",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 34),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EmailField(controller: _nikController),
                      const SizedBox(height: 20),
                      PasswordField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        onObscureTextChanged: (value) {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      RememberMeCheckbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value;
                          });
                          saveRememberMe();
                        },
                      ),
                      const SizedBox(height: 35),
                      LoginButton(loginCallback: loginFunc),
                      const SizedBox(height: 20),
                      const FingerprintButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RememberMeCheckbox extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;

  const RememberMeCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text("Remember me"),
          value: widget.value,
          onChanged: (value) {
            setState(() {
              widget.onChanged(value!);
            });
          },
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function() loginCallback;

  const LoginButton({Key? key, required this.loginCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loginCallback,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(4),
            right: Radius.circular(4),
          ),
        ),
      ),
      child: const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

class FingerprintButton extends StatelessWidget {
  const FingerprintButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the onPressed logic here.
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(4),
            right: Radius.circular(4),
          ),
          side: BorderSide(color: Colors.blue),
        ),
      ),
      child: const Text(
        "Fingerprint",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ),
      ),
    );
  }
}
