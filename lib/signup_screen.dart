import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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


  Future<void> _signUp() async {
    //Recuperar los datos de los controllers
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = _phoneController.text;
    final birthday = _birthdayController.text;


    //Llamar a la funcion de firebase auth para registrar.
    UserCredential credential = await FirebaseAuth.instance
     .createUserWithEmailAndPassword(email: email, password: password);

     // Obtener el user id del usuario
     String uid = credential.user!.uid;

    // Guardar los datos del usuario en la coleccion users/ con referencia el uid del usuario registrado
    // /users/{uid}/
    await FirebaseFirestore.instance
     .collection('users')
     .doc(uid)
     .set(
      {
        'name': name,
        'email': email,
        'phone': phone,
        'birthday': birthday,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      }
     );

    // Redirigir a la pantalla de inicio de session o pop
    context.pop();
  }

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
                  log('Realizar el registro');
                  _signUp();
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}