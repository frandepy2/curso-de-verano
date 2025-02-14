import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curso_de_verano/core/helpers/account_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInitialized = false;

  //Atributo que guarde los datos del usuario logueado
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    getUserData();
    registerScreen();
  }

  Future<void> registerScreen()async {
     await FirebaseAnalytics.instance.logScreenView( screenName:  "home-screen");
  }

  Future<void> getUserData() async {
    // Obtener el uid del usuario
    final uid = FirebaseAuth.instance.currentUser!.uid;

    log(uid);

    // Con el uid del usuario vamos a consultar en Firestore /users/{uid} y traeremos los datos del usuario
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    // Mapeamos los datos y devolvemos
    userData = snapshot.data()! as Map<String, dynamic>;

    AccountHelper.instance.setCurrentUser(userData!);

    setState(() {
      isInitialized = true;
    });
  }

  var items = [
    {"tille" : "Noticia 1", "url": "https://picsum.photos/seed/picsum/200/300"},
    {"tille" : "Noticia 2", "url": "https://picsum.photos/seed/a/200/300"},
    {"tille" : "Noticia 3", "url": "https://picsum.photos/seed/b/200/300"},
    {"tille" : "Noticia 4", "url": "https://picsum.photos/seed/c/200/300"},
    {"tille" : "Noticia 5", "url": "https://picsum.photos/seed/d/200/300"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: SafeArea(
        child: isInitialized
            ? Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Bienvenido al Curso de Verano",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Ultimas Noticias",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(height: 400.0),
                      items: items.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Image.network(
                                    item['url']!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 400,
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    child: Text(
                                      item['tille']!,
                                      style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ,color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8,),

                    // Agregar un listTile de cada noticia

                  ],
                  
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
