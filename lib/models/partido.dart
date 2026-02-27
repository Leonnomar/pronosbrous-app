enum RondaEliminatoria {
    dieciseisavos,
    octavos,
    cuartos,
    semifinal,
    tercerLugar,
    finalRonda
}
    
class Partido {
    final String equipoLocal;
    final String equipoVisitante;
    final int golesLocal;
    final int golesVisitante;
    final String fase;
    final RondaEliminatoria? ronda;
    final String? equipoClasificadoReal;
    final bool tienePenales;

    Partido({
        required this.equipoLocal,
        required this.equipoVisitante,
        required this.golesLocal,
        required this.golesVisitante,
        required this.fase,
        this.ronda,
        this.equipoClasificadoReal,
        this.tienePenales = false,
    });

    bool get esEmpate => golesLocal == golesVisitante;

    bool get ganaLocal => golesLocal > golesVisitante;

    bool get ganaVisitante => golesVisitante > golesLocal;
}