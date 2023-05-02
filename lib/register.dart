import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ticketing_system/utils/api_utils.dart';
import 'package:ticketing_system/utils/dialog_utils.dart';
import 'package:ticketing_system/utils/token_util.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [Body()],
      ),
    );
  }
}

class Body extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Body({super.key});

  register(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      DialogService.showMyDialog(
          context, 'Oops', 'Password confirmation does not match');
      return;
    }

    final response =
        await ApiUtils.submitData(context, 'api/v1/auth/register', {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      await TokenUtil().storeToken(data['token']);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/');
    } else if (response.statusCode != 422) {
      // ignore: use_build_context_synchronously
      DialogService.showMyDialog(context, 'Oops', data['message']);
    } else {
      final message = data['errors'][0]['msg'];
      // ignore: use_build_context_synchronously
      DialogService.showMyDialog(context, 'Oops', message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up to \nClickr Desk',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "If you already have an account",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "You can",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Login here!",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 30,
              vertical: MediaQuery.of(context).size.height / 20),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 15,
              vertical: MediaQuery.of(context).size.height / 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(108, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 196, 196, 196),
                spreadRadius: 30,
                blurRadius: 100,
              ),
            ],
          ),
          child: SizedBox(
            width: 320,
            child: Form(key: _formKey, child: _formRegister(context)),
          ),
        )
      ],
    );
  }

  Widget _formRegister(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        TextFormField(
          controller: nameController,
          decoration: _inputDecoration.copyWith(
            hintText: 'Enter your name',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(height: 30),
        TextFormField(
          controller: emailController,
          decoration: _inputDecoration.copyWith(
            hintText: 'email address',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your email address';
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                .hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
        const SizedBox(height: 30),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: _inputDecoration.copyWith(
            hintText: 'password',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        const SizedBox(height: 30),
        TextFormField(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: _inputDecoration.copyWith(
            hintText: 'confirm password',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please confirm your password';
            }
            return null;
          },
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            onPressed: () => {
              if (_formKey.currentState!.validate()) {register(context)}
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Register"))),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

final _inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.blueGrey[50],
  labelStyle: const TextStyle(fontSize: 12),
  contentPadding: const EdgeInsets.only(left: 30),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueGrey),
    borderRadius: BorderRadius.circular(15),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueGrey),
    borderRadius: BorderRadius.circular(15),
  ),
);
