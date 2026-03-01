import 'package:flutter/material.dart';
import 'models/partido.dart';
import 'models/prediccion.dart';
import 'models/serie_eliminatoria.dart';

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
      golesLocal: 2,
      golesVisitante: 1,
      fase: "Cuartos",
      ronda: RondaEliminatoria.cuartos,
      serieId: "serie1",
      esVuelta: false,
    ),
    Partido(
      equipoLocal: "Juventus",
      equipoVisitante: "Manchester City",
      golesLocal: 0,
      golesVisitante: 1,
      fase: "Cuartos",
      ronda: RondaEliminatoria.cuartos,
      serieId: "serie1",
      esVuelta: true,
      fueAPenales: false,
    ),
  ];

  final List<SerieEliminatoria> series = [
    SerieEliminatoria(
      id: "serie1",
      equipoLocal: "Manchester City",
      equipoVisitante: "Juventus",
      golesGlobalLocal: 3,
      golesGlobalVisitante: 1,
      clasificadoReal: "Manchester City",
      ronda: RondaEliminatoria.cuartos,
    ),
  ];

  final Map<int, Prediccion> predicciones = {
    0: Prediccion(golesLocal: 2, golesVisitante: 1),
    1: Prediccion(golesLocal: 0, golesVisitante: 0),
    2: Prediccion(golesLocal: 3, golesVisitante: 1),
  };

  Map<int, String?> ganadorPenalesUsuario = {};

  List<int> puntosUsuario = [];

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

  String? obtenerClasificadoPredicho(String serieId) {
    final SerieEliminatoria serie = series.firstWhere((s) => s.id == serieId);

    final partidosSerie =
        partidos.where((p) => p.serieId == serieId).toList();
    

    int globalLocal = 0;
    int globalVisitante = 0;

    for (var partido in partidosSerie) {
      final index = partidos.indexOf(partido);
      final prediccion = predicciones[index];

      if (prediccion == null) return null;

      if (partido.equipoLocal == serie.equipoLocal) {
        globalLocal += prediccion.golesLocal;
        globalVisitante += prediccion.golesVisitante;
      } else {
        globalLocal += prediccion.golesVisitante;
        globalVisitante += prediccion.golesLocal;
      }
    }

    if (globalLocal > globalVisitante) {
      return serie.equipoLocal;
    } else if (globalVisitante > globalLocal) {
      return serie.equipoVisitante;
    } else {
      return null;
    }
  }

  bool debeMostrarPenales(int index) {
    final partido = partidos[index];
    final prediccion = predicciones[index];

    if (prediccion == null) return false;

    // Caso liga normal
    if (partido.serieId == null) return false;

    // Partido único
    final partidosSerie = partidos.where((p) => p.serieId == partido.serieId).toList();

    if (partidosSerie.length == 1) {
      return prediccion.golesLocal == prediccion.golesVisitante;
    }

    // Ida y vuelta
    if (!partido.esVuelta) return false;

    final clasificado = obtenerClasificadoPredicho(partido.serieId!);

    // Si es null = empate global
    return clasificado == null;
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
    if (partido.serieId != null && partido.esVuelta) {
      String? clasificadoPredicho = obtenerClasificadoPredicho(partido.serieId!);
      
      final SerieEliminatoria serie = series.firstWhere((s) => s.id == partido.serieId);

      if (clasificadoPredicho == serie.clasificadoReal) {
        puntos += obtenerBonusRonda(partido.ronda!);
      }
    }


    // Bonus por penales
    if (partido.serieId != null && partido.esVuelta) {
      
      String? clasificadoPredicho = obtenerClasificadoPredicho(partido.serieId!);

      final SerieEliminatoria serie = series.firstWhere((s) => s.id == partido.serieId);
      
      if (clasificadoPredicho == null &&
        ganadorPenalesUsuario[index] != null &&
        ganadorPenalesUsuario[index] == serie.clasificadoReal) {
      puntos += 2;
      }
    }

    return puntos;
  }

  @override
  void initState() {
    super.initState();

    puntosUsuario = List.filled(partidos.length, 0);
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

          bool mostrarPenales = debeMostrarPenales(index);

          String? clasificadoPredicho;

          if (partido.serieId != null) {
            clasificadoPredicho = obtenerClasificadoPredicho(partido.serieId!);
          }

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

                  if (mostrarPenales) ...[
                    const SizedBox(height: 10),
                    const Text("¿Quién gana en penales?"),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ganadorPenalesUsuario[index] == partido.equipoLocal
                                ? Colors.green
                                : Colors.grey[300],
                            foregroundColor: ganadorPenalesUsuario[index] == partido.equipoLocal
                                ? Colors.white
                                : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              ganadorPenalesUsuario[index] = partido.equipoLocal;
                            });
                          },
                          child: Text(partido.equipoLocal),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ganadorPenalesUsuario[index] == partido.equipoVisitante
                                ? Colors.green
                                : Colors.grey[300],
                            foregroundColor: ganadorPenalesUsuario[index] == partido.equipoVisitante
                                ? Colors.white
                                : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              ganadorPenalesUsuario[index] = partido.equipoVisitante;
                            });
                          },
                          child: Text(partido.equipoVisitante),
                        ),
                      ],
                    ),
                    // Bonus por penales
                    if (partido.serieId != null &&
                        partido.esVuelta &&
                        clasificadoPredicho == null &&
                        ganadorPenalesUsuario[index] != null &&
                        ganadorPenalesUsuario[index] == series.firstWhere((s) => s.id == partido.serieId).clasificadoReal) ...[
                      const SizedBox(height: 6),
                      const Text(
                        "+2 puntos bonus por penales 🎯",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],

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