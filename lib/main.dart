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
      ronda: RondaEliminatoria.finalRonda,
      equipoClasificadoReal: "Manchester City",
    ),
  ];

  final Map<int, Prediccion> predicciones = {
    0: Prediccion(golesLocal: 2, golesVisitante: 1),
    1: Prediccion(golesLocal: 0, golesVisitante: 0),
    2: Prediccion(golesLocal: 3, golesVisitante: 1),
  };

  int obtenerBonusRonda(RondaEliminatoria ronda) {
    switch (ronda) {
      case RondaEliminatoria.dieciseisavos:
        return 1;
      case RondaEliminatoria.octavos:
        return 2;
      case RondaEliminatoria.cuartos:
        return 3;
      case RondaEliminatoria.semifinal:
        return 4;
      case RondaEliminatoria.tercerLugar:
        return 4;
      case RondaEliminatoria.finalRonda:
        return 5;
    }
  }

  int calcularPuntos(int index) {
    final partido = partidos[index];
    final prediccion = predicciones[index];

    if (prediccion == null) return 0;

    int puntos = 0;

    // Marcador exacto
    bool marcadorExacto =
        partido.golesLocal == prediccion.golesLocal &&
        partido.golesVisitante == prediccion.golesVisitante;

    // Acierta ganador
    bool mismoResultado =
        (partido.golesLocal > partido.golesVisitante &&
            prediccion.golesLocal > prediccion.golesVisitante) ||
        (partido.golesLocal < partido.golesVisitante &&
            prediccion.golesLocal < prediccion.golesVisitante) ||
        (partido.golesLocal == partido.golesVisitante &&
            prediccion.golesLocal == prediccion.golesVisitante);

    if (marcadorExacto) {
      puntos += 5;
    } else if (mismoResultado) {
      puntos += 3;
    }

    // Bonus por eliminatoria
    if (partido.ronda != null) {
      String clasificadoReal = partido.equipoClasificadoReal!;

      String clasificadoPredicho;

      if (prediccion.golesLocal > prediccion.golesVisitante) {
        clasificadoPredicho = partido.equipoLocal;
      } else if (prediccion.golesLocal < prediccion.golesVisitante) {
        clasificadoPredicho = partido.equipoVisitante;
      } else {
        clasificadoPredicho = prediccion.equipoClasificado ?? "";
      }
      if (clasificadoPredicho == clasificadoReal) {
        puntos += obtenerBonusRonda(partido.ronda!);
      }
    }

    return puntos;
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
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${partido.equipoLocal} vs ${partido.equipoVisitante}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text("Resultado real: ${partido.golesLocal} - ${partido.golesVisitante}"),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Goles Local",
                          ),
                          onChanged: (value) {
                            final golesLocal = int.tryParse(value) ?? 0;
                            final actual = predicciones[index];

                            setState(() {
                              predicciones[index] = Prediccion(
                                golesLocal: golesLocal,
                                golesVisitante: actual?.golesVisitante ?? 0,
                              );
                            });
                          },
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Goles Visitante",
                          ),
                          onChanged: (value) {
                            final golesVisitante = int.tryParse(value) ?? 0;
                            final actual = predicciones[index];

                            setState(() {
                              predicciones[index] = Prediccion(
                                golesLocal: actual?.golesLocal ?? 0,
                                golesVisitante: golesVisitante,
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Puntos: ${calcularPuntos(index)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}