import 'partido.dart';

enum TipoDesempate {
    penales,
    golVisitante,
    posicionTabla,
}

class SerieEliminatoria {
    final String id;
    final String equipoLocal;
    final String equipoVisitante;

    final int golesGlobalLocal;
    final int golesGlobalVisitante;

    final String clasificadoReal;

    final TipoDesempate tipoDesempate;
    final RondaEliminatoria ronda;

    SerieEliminatoria({
        required this.id,
        required this.equipoLocal,
        required this.equipoVisitante,
        required this.golesGlobalLocal,
        required this.golesGlobalVisitante,
        required this.clasificadoReal,
        required this.tipoDesempate,
        required this.ronda,
    });
}