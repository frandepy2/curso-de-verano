import "package:curso_de_verano/login_screen.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";


class LaunchScreen extends StatelessWidget {

  static const routeName = "/launch";

  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 13, 20, 112),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(130),
                    bottomRight: Radius.circular(130),
                  )
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.34,
                left: MediaQuery.of(context).size.width * 0.37,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 241, 241, 241),
                  ),
                  child: Center(
                    child: Icon(Icons.yard, size: 80, color: Colors.black,),
                  ),
                ),

              )
            ],
          ),

          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Curso de Verano",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold ),
            ),
          ),

          SizedBox(height: 10),
          Center(
            child: Text(
              "Aprende Flutter desde cero",
              style: TextStyle(fontSize: 18,),
            ),
          ),
          Spacer(),
          ElevatedButton(onPressed: (){
            context.go(LoginScreen.routeName);
          }, child: Text("Iniciar Session")),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}