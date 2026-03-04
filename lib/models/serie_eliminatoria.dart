import 'partido.dart';

class SerieEliminatoria {
    final String id;
    final String equipoLocal;
    final String equipoVisitante;

    final int golesGlobalLocal;
    final int golesGlobalVisitante;

    final String clasificadoReal;
    final bool reglaGolVisitante;

    final RondaEliminatoria ronda;

    SerieEliminatoria({
        required this.id,
        required this.equipoLocal,
        required this.equipoVisitante,
        required this.golesGlobalLocal,
        required this.golesGlobalVisitante,
        required this.clasificadoReal,
        this.reglaGolVisitante = false,
        required this.ronda,
    });
}