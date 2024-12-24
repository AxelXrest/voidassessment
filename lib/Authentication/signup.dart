import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  Future<void> _signup() async {
    final url = "https://interview-mock-api.onrender.com/signup";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"ContentType": "application/json"},
        body: jsonEncode({'username': username, 'password': password}),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User has been created")));
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Fields are missing")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("External Error")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Internal Error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Username"),
                onChanged: (value) {
                  username = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    _signup();
                  }
                },
                child: const Text("Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
