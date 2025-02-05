import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curso_de_verano/selfie_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SignUpScreen extends StatefulWidget {

  static const routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}




class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
        Padding(padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Título
              Text('Registro', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),

              //Nombre y Apellido
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre y Apellido',
                  hintText: 'Ejemplo : Francisco Sanabria',
                ),
              ),
              const SizedBox(height: 16,),
              //Email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Ejemplo : ejemplo@fpuna.edu.py'),),
              const SizedBox(height: 16,),
              //Numero de telefono
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Numero de telefono',
                  hintText: 'Ejemplo : 0981 123 456'),
              ),
              const SizedBox(height: 16,),
              // Contrasena
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Ejemplo : 123456'),
              ),
              const SizedBox(height: 16,),
              // Fecha de nacimiento
              TextField(
                controller: _birthdayController,
                decoration: InputDecoration(
                  labelText: 'Fecha de nacimiento',
                  hintText: 'Ejemplo : 01/01/2000'),
              ),
              Spacer(),
              // Boton de registro
              ElevatedButton(
                onPressed: () async {
                  // Realizar la accion de registro
                  context.push('/selfie?name=${_nameController.text}&password=${ _passwordController.text}&email=${_emailController.text}&phone=${_phoneController.text}&birthday=${_birthdayController.text}');
                },
                child: Text('Siguiente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}