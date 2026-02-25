import 'package:flutter/material.dart';
import 'models/partido.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                "Marcador: ${partido.golesLocal} - ${partido.golesVisitante}\nFase: ${partido.fase}",
              ),
            ),
          );
        },
      ),
    );
  }
}