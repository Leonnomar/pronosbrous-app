import 'package:flutter/material.dart';
import 'models/partido.dart';
import 'models/prediccion.dart';

void main() {
  runApp(const PronosBrousApp());
}

class PronosBrousApp extends StatelessWidget {
  const PronosBrousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PronósBrous',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Partido> partidos = [
    Partido(
      equipoLocal: "América",
      equipoVisitante: "Chivas",
      golesLocal: 0,
      golesVisitante: 1,
      fase: "Jornada 6",
    ),
    Partido(
      equipoLocal: "Real Madrid",
      equipoVisitante: "Barcelona",
      golesLocal: 1,
      golesVisitante: 3,
      fase: "Jornada 28",
    ),
    Partido(
      equipoLocal: "Manchester City",
      equipoVisitante: "Juventus",
      golesLocal: 3,
      golesVisitante: 1,
      fase: "Final",
    ),
  ];

  final Map<int, Prediccion> predicciones = {
    0: Prediccion(golesLocal: 2, golesVisitante: 1),
    1: Prediccion(golesLocal: 0, golesVisitante: 0),
    2: Prediccion(golesLocal: 3, golesVisitante: 1),
  };

  int calcularPuntos(int index) {
    final partido = partidos[index];
    final prediccion = predicciones[index];

    if (prediccion == null) return 0;

    // Marcador exacto
    if (partido.golesLocal == prediccion.golesLocal &&
        partido.golesVisitante == prediccion.golesVisitante) {
      return 5;
    }

    // Acierta ganador
    if ((partido.golesLocal > partido.golesVisitante &&
            prediccion.golesLocal > prediccion.golesVisitante) ||
        (partido.golesLocal < partido.golesVisitante &&
            prediccion.golesLocal < prediccion.golesVisitante)) {
      return 3;
    }
    
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PronósBrous ⚽"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: partidos.length,
        itemBuilder: (context, index) {
          final partido = partidos[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                "${partido.equipoLocal} vs ${partido.equipoVisitante}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Marcador: ${partido.golesLocal} - ${partido.golesVisitante}\n"
                "Fase: ${partido.fase}\n"
                "Puntos: ${calcularPuntos(index)}",
              ),
            ),
          );
        },
      ),
    );
  }
}