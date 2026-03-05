import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/partido.dart';
import 'models/prediccion.dart';
import 'models/serie_eliminatoria.dart';

class MaxGoalsInputFormatter extends TextInputFormatter {
  final int max;

  MaxGoalsInputFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final int? value = int.tryParse(newValue.text);

    if (value == null) return oldValue;

    if (value > max) {
      return oldValue;
    }

    return newValue;
  }
}

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
      torneo: "Liga BBVA",
      equipoLocal: "América",
      equipoVisitante: "Chivas",
      golesLocal: 0,
      golesVisitante: 1,
      fase: "Jornada 6",
      fechaHora: DateTime(2026, 2, 10, 21, 0),
    ),
    Partido(
      torneo: "La Liga",
      equipoLocal: "Real Madrid",
      equipoVisitante: "Barcelona",
      golesLocal: 1,
      golesVisitante: 3,
      fase: "Jornada 28",
      fechaHora: DateTime(2026, 4, 10, 13, 0),
    ),
    Partido(
      torneo: "Champions League",
      equipoLocal: "Manchester City",
      equipoVisitante: "Juventus",
      golesLocal: 2,
      golesVisitante: 1,
      fase: "Cuartos",
      ronda: RondaEliminatoria.cuartos,
      serieId: "serie1",
      esVuelta: false,
      fechaHora: DateTime(2026, 3, 10, 13, 0),
    ),
    Partido(
      torneo: "Champions League",
      equipoLocal: "Juventus",
      equipoVisitante: "Manchester City",
      golesLocal: 0,
      golesVisitante: 1,
      fase: "Cuartos",
      ronda: RondaEliminatoria.cuartos,
      serieId: "serie1",
      esVuelta: true,
      fueAPenales: false,
      fechaHora: DateTime(2026, 4, 10, 13, 0),
    ),
    Partido(
      torneo: "Champions League",
      equipoLocal: "PSG",
      equipoVisitante: "Inter",
      golesLocal: 5,
      golesVisitante: 0,
      fase: "Final",
      ronda: RondaEliminatoria.finalRonda,
      serieId: "final1",
      esVuelta: false,
      fechaHora: DateTime(2025, 8, 31, 13, 0),
    ),
    Partido(
      torneo: "CONCACAF Champions Cup",
      equipoLocal: "LAFC",
      equipoVisitante: "Tigres",
      golesLocal: 1,
      golesVisitante: 2,
      fase: "Cuartos",
      ronda: RondaEliminatoria.cuartos,
      serieId: "serieConcacaf",
      esVuelta: false,
      fechaHora: DateTime(2026, 1, 10, 19, 0),
    ),
    Partido(
      torneo: "CONCACAF Champions Cup",
      equipoLocal: "Tigres",
      equipoVisitante: "LAFC",
      golesLocal: 0,
      golesVisitante: 1,
      fase: "Cuartos",
      ronda: RondaEliminatoria.cuartos,
      serieId: "serieConcacaf",
      esVuelta: true,
      fueAPenales: false,
      fechaHora: DateTime(2026, 2, 10, 19, 0),
    ),
    Partido(
      torneo: "Liga BBVA",
      equipoLocal: "Guadalajara",
      equipoVisitante: "Cruz Azul",
      golesLocal: 0,
      golesVisitante: 0,
      fase: "Cuartos",
      ronda: RondaEliminatoria.cuartos,
      serieId: "liguilla_cuartos_1",
      esVuelta: false,
      fechaHora: DateTime(2025, 12, 10, 18, 0),
    ),
    Partido(
      torneo: "Liga BBVA",
      equipoLocal: "Cruz Azul",
      equipoVisitante: "Guadalajara",
      golesLocal: 3,
      golesVisitante: 2,
      fase: "Cuartos",
      ronda: RondaEliminatoria.cuartos,
      serieId: "liguilla_cuartos_1",
      esVuelta: true,
      fueAPenales: false,
      fechaHora: DateTime(2025, 12, 14, 21, 0),
    )
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
      tipoDesempate: TipoDesempate.penales,
    ),
    SerieEliminatoria(
      id: "final1",
      equipoLocal: "PSG",
      equipoVisitante: "Inter",
      golesGlobalLocal: 5,
      golesGlobalVisitante: 0,
      clasificadoReal: "PSG",
      ronda: RondaEliminatoria.finalRonda,
      tipoDesempate: TipoDesempate.penales,
    ),
    SerieEliminatoria(
      id: "serieConcacaf",
      equipoLocal: "LAFC",
      equipoVisitante: "Tigres",
      golesGlobalLocal: 2,
      golesGlobalVisitante: 2,
      clasificadoReal: "Tigres",
      ronda: RondaEliminatoria.cuartos,
      tipoDesempate: TipoDesempate.golVisitante,
    ),
    SerieEliminatoria(
      id: "liguilla_cuartos_1",
      equipoLocal: "Cruz Azul",
      equipoVisitante: "Guadalajara",
      golesGlobalLocal: 3,
      golesGlobalVisitante: 2,
      clasificadoReal: "Cruz Azul",
      ronda: RondaEliminatoria.cuartos,
      tipoDesempate: TipoDesempate.posicionTabla,
    ),
  ];

  final Map<int, Prediccion> predicciones = {};

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
    final SerieEliminatoria serie = series.firstWhere((s) => s.id == serieId!);

    final partidosSerie =
        partidos.where((p) => p.serieId == serieId).toList();
    
    int globalLocal = 0;
    int globalVisitante = 0;

    int golesVisitanteLocal = 0;
    int golesVisitanteVisitante = 0;

    for (var partido in partidosSerie) {
      final index = partidos.indexOf(partido);
      final prediccion = predicciones[index];

      if (prediccion == null ||
          prediccion.golesLocal == null ||
          prediccion.golesVisitante == null) {
        return null;
      }

      final golesLocal = prediccion.golesLocal!;
      final golesVisitante = prediccion.golesVisitante!;

      if (!partido.esVuelta) {
        globalLocal += golesLocal;
        globalVisitante += golesVisitante;

        golesVisitanteVisitante += golesVisitante;
      } else {
        globalLocal += golesVisitante;
        globalVisitante += golesLocal;

        golesVisitanteLocal += golesVisitante;
      }
    }

    // Decide por global
    if (globalLocal > globalVisitante) {
      return serie.equipoLocal;
    }
    if (globalVisitante > globalLocal) {
      return serie.equipoVisitante;
    }

    // Regla de desempate
    switch (serie.tipoDesempate) {
      case TipoDesempate.golVisitante:
        if (golesVisitanteLocal > golesVisitanteVisitante) {
          return serie.equipoLocal;
        }
        if (golesVisitanteVisitante > golesVisitanteLocal) {
          return serie.equipoVisitante;
        }
        return null;
      
      case TipoDesempate.posicionTabla:
        return serie.clasificadoReal;
      
      case TipoDesempate.penales:
        return null;
    }
  }

  bool debeMostrarPenales(int index) {
    final partido = partidos[index];
    final prediccion = predicciones[index];

    final mostrarPenales =
        prediccion != null &&
        prediccion.golesLocal != null &&
        prediccion.golesVisitante != null &&
        prediccion.golesLocal == prediccion.golesVisitante;

    if (prediccion == null) return false;

    // Caso liga normal
    if (partido.serieId == null) return false;

    // Partido único
    final partidosSerie = partidos.where((p) => p.serieId == partido.serieId).toList();

    if (partidosSerie.length == 1) {
      return prediccion.golesLocal == prediccion.golesVisitante;
    }

    // Ida y vuelta
    if (partidosSerie.length == 2 && partido.esVuelta) {

      for (var p in partidosSerie) {
        final i = partidos.indexOf(p);
        final pred = predicciones[i];

        if (pred == null ||
            pred.golesLocal == null ||
            pred.golesVisitante == null) {
          return false;
        }
      }
      final clasificado = obtenerClasificadoPredicho(partido.serieId!);

      // Si es null = empate global
      return clasificado == null;
    }

    final SerieEliminatoria serie = series.firstWhere((s) => s.id == partido.serieId!);

    if (serie.tipoDesempate != TipoDesempate.penales) {
      return false;
    }

    return false;
  }

  int calcularPuntos(int index) {
    final partido = partidos[index];
    final prediccion = predicciones[index];

    if (prediccion == null ||
        prediccion.golesLocal == null ||
        prediccion.golesVisitante == null) {
      return 0;
    }

    final golesLocal = prediccion.golesLocal!;
    final golesVisitante = prediccion.golesVisitante!;

    int puntos = 0;

    // Marcador exacto
    bool marcadorExacto =
        partido.golesLocal == golesLocal &&
        partido.golesVisitante == golesVisitante;

    // Acierta ganador
    bool mismoResultado =
        (partido.golesLocal > partido.golesVisitante &&
            golesLocal > golesVisitante) ||
        (partido.golesLocal < partido.golesVisitante &&
            golesLocal < golesVisitante) ||
        (partido.golesLocal == partido.golesVisitante &&
            golesLocal == golesVisitante);

    if (marcadorExacto) {
      puntos += 5;
    } else if (mismoResultado) {
      puntos += 3;
    }

    // Bonus por eliminatoria
    if (partido.serieId != null) {

      final partidosSerie = partidos.where((p) => p.serieId == partido.serieId).toList();

      final SerieEliminatoria serie = series.firstWhere((s) => s.id == partido.serieId);

      String? clasificadoPredicho = obtenerClasificadoPredicho(partido.serieId!);

      bool esPartidoUnico = partidosSerie.length == 1;
      bool esVuelta = partidosSerie.length == 2 && partido.esVuelta;

      if (esPartidoUnico || esVuelta) {
  
        if (clasificadoPredicho == serie.clasificadoReal) {
          puntos += obtenerBonusRonda(partido.ronda!);
        }
    
        // Bonus por penales
        if (clasificadoPredicho == null &&
            ganadorPenalesUsuario[index] != null &&
            ganadorPenalesUsuario[index] == serie.clasificadoReal) {
          puntos += 2;
        }
      }
    }

    if (golesLocal == null || golesVisitante == null) {
      return 0;
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
    // Torneo -> Ronda -> Lista de índices
    Map<String, Map<RondaEliminatoria?, List<int>>> estructura = {};

    for (int i = 0; i < partidos.length; i++) {
      final partido = partidos[i];

      estructura.putIfAbsent(partido.torneo, () => {});
      estructura[partido.torneo]!
          .putIfAbsent(partido.ronda, () => []);

      estructura[partido.torneo]![partido.ronda]!.add(i);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("PronósBrous ⚽"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: estructura.entries.map((torneoEntry) {

          final torneo = torneoEntry.key;
          final rondas = torneoEntry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical:10),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      torneo,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              ...rondas.entries.map((rondaEntry) {

                final ronda = rondaEntry.key;
                final indices = rondaEntry.value;

                int totalRonda = 0;
                for (var i in indices) {
                  totalRonda += puntosUsuario[i];
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      ronda?.name.toUpperCase() ?? "FASE REGULAR",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Text(
                      "Total ronda: $totalRonda pts",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox (height: 8),

                    ...indices.map((i) => buildPartidoCard(i)).toList(),

                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget buildPartidoCard(int index) {

    final partido = partidos[index];
    final mostrarPenales = debeMostrarPenales(index);

    String? clasificadoPredicho;
    if (partido.serieId != null) {
      clasificadoPredicho = obtenerClasificadoPredicho(partido.serieId!);
    }

    String fechaFormateada = "";

    if (partido.fechaHora != null) {
      final fecha = partido.fechaHora!;
      fechaFormateada = DateFormat("dd MMM yyyy • HH:mm").format(fecha);
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
                fontSize: 16,
              ),
            ),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(height: 4),
                Text(
                  fechaFormateada,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text("Resultado real: ${partido.golesLocal} - ${partido.golesVisitante}"),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                      MaxGoalsInputFormatter(30),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Goles Local",
                    ),
                    onChanged: (value) {
                      setState (() {
                        final actual = predicciones[index];

                        if (value.isEmpty) {
                          predicciones[index] = Prediccion(
                            golesLocal: null,
                            golesVisitante: actual?.golesVisitante,
                          );
                        } else {
                          predicciones[index] = Prediccion(
                            golesLocal: int.parse(value),
                            golesVisitante: actual?.golesVisitante,
                          );
                        }
                        puntosUsuario[index] = calcularPuntos(index);
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                      MaxGoalsInputFormatter(30),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Goles Visitante",
                    ),
                    onChanged: (value) {
                      setState(() {
                        final actual = predicciones[index];

                        if (value.isEmpty) {
                          predicciones[index] = Prediccion(
                            golesLocal: actual?.golesLocal,
                            golesVisitante: null,
                          );
                        } else {
                          predicciones[index] = Prediccion(
                            golesLocal: actual?.golesLocal,
                            golesVisitante: int.parse(value),
                          );
                        }

                        puntosUsuario[index] = calcularPuntos(index);
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
                        puntosUsuario[index] = calcularPuntos(index);
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
                        puntosUsuario[index] = calcularPuntos(index);
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
              "Puntos: ${puntosUsuario[index]}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}